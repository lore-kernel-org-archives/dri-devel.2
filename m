Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D0606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lY2PMZul
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E83E910EC30;
	Mon, 16 Nov 2026 08:50:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C2CD10EB70
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 08:50:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21A02416DC;
 Mon, 16 Nov 2026 08:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DE81F000C4;
 Mon, 16 Nov 2026 08:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794819048;
 bh=Ykhww1nthW6bqToDe0TC5bF8+P4T9qm24ET3jJfkL3k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=lY2PMZulIl+be9JXXzRvm0PpoVSaC93EFGrSXbgwHyNUdUszeC7SgtDNKhyDaXDHT
 mNjdrLNc/Hp00Zva4kuGX5O/teLRU2/lIKx17PdGidPS6g9EiSyFkmIy/Dw5s2qa1N
 hzLGZSADHPWOO3zvIKVTWa31qZcgiUs4l1SMcWVVYaQg7T9gLqdjyb56PH4yZ7MSQL
 pApLjBFC83+yhyrAVtxyZAMPhdFLz5RkriALOIPEuIpFFqQC2gi+rrJfQ7aSMyotKd
 5Q2NiqWN4zWSLOTg5GYrfyBBfBdTW2pCIAnO1p8Dy2idehILizntZDu4ut/wxUFowx
 KO95kGi6TEXjg==
Message-ID: <3ef6096a-45f8-4c78-8ca1-ac354a1fc131@kernel.org>
Date: Mon, 16 Nov 2026 08:50:44 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] misc: fastrpc: Fix double free and races in
 fastrpc_req_mmap() error path
To: Yao Yiqi <yaoyiqi3@huawei.com>, Srinivas Kandagatla <srini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260930071340.2969948-1-yaoyiqi3@huawei.com>
From: Srinivas Kandagatla <srini@kernel.org>
Content-Language: en-US
In-Reply-To: <20260930071340.2969948-1-yaoyiqi3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 9/30/26 8:13 AM, Yao Yiqi wrote:
> fastrpc_req_mmap() links the newly allocated buffer into fl->mmaps before
> copying the response back to userspace. If copy_to_user() fails, the
> err_assign path calls fastrpc_req_munmap_impl() to unmap the buffer from
> the DSP and, on success, to free it.
> 
> Since commit 6102ceb4eab8 ("misc: fastrpc: Remove buffer from list prior
> to unmap operation"), fastrpc_req_munmap_impl() no longer removes the
> buffer from fl->mmaps, as that is now the responsibility of the caller.
> fastrpc_req_mmap() was not updated accordingly, so the buffer is freed
> while still linked in the list. The fl->mmaps cleanup in
> fastrpc_user_free() then calls list_del() and fastrpc_buf_free() on the
> already freed buffer, resulting in a use-after-free and a double free.
> 
> Publishing the buffer before copy_to_user() returns is also racy:
> another thread of the same process can read the DSP address from the
> partially written user buffer (or via userfaultfd) and issue
> FASTRPC_IOCTL_MUNMAP, which unlinks and frees the buffer while
> fastrpc_req_mmap() is still using it.
> 
> Fix this by adding the buffer to fl->mmaps only after copy_to_user() has
> succeeded, so the buffer is not visible to a concurrent unmap while the
> response is still being copied. If unmapping the buffer fails on the
> error path, fastrpc_buf_free() is not called, so re-add the buffer to
> fl->mmaps to keep it tracked and let fastrpc_user_free() reclaim it on
> release instead of leaking the DMA allocation.
> 
> Fixes: 6102ceb4eab8 ("misc: fastrpc: Remove buffer from list prior to unmap operation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
> ---

This does not apply!, can you rebase on latest branch and send


--srini

> Changes in v3:
>  - Re-add the buffer to fl->mmaps if unmapping it on the error path
>    fails, since fastrpc_buf_free() is not called in that case and the
>    DMA allocation would otherwise be leaked.
> 
> Changes in v2:
>  - Link the buffer into fl->mmaps only after copy_to_user() succeeds.
>    Besides fixing the double free, this also closes the concurrent
>    FASTRPC_IOCTL_MUNMAP race, where a partially written user buffer let
>    another thread unmap and free the buffer while fastrpc_req_mmap() was
>    still using it.
> 
>  drivers/misc/fastrpc.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d4fac2caca86..917a5dfe3774 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2153,22 +2153,26 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>  		}
>  	}
>  
> -	spin_lock(&fl->lock);
> -	list_add_tail(&buf->node, &fl->mmaps);
> -	spin_unlock(&fl->lock);
> -
>  	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
>  		err = -EFAULT;
>  		goto err_assign;
>  	}
>  
> +	spin_lock(&fl->lock);
> +	list_add_tail(&buf->node, &fl->mmaps);
> +	spin_unlock(&fl->lock);
> +
>  	dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
>  		buf->raddr, buf->size);
>  
>  	return 0;
>  
>  err_assign:
> -	fastrpc_req_munmap_impl(fl, buf);
> +	if (fastrpc_req_munmap_impl(fl, buf)) {
> +		spin_lock(&fl->lock);
> +		list_add_tail(&buf->node, &fl->mmaps);
> +		spin_unlock(&fl->lock);
> +	}
>  
>  	return err;
>  }

