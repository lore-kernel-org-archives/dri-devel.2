Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D76606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zA9575AF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96CD110F9F2;
	Wed, 25 Nov 2026 08:41:26 +0000 (UTC)
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 480FC10F6A2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:48:34 +0000 (UTC)
Received: by mail-dy2-f7.google.com with SMTP id
 5a478bee46e88-3869c1f4d19so1149568eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795531713; x=1796136513; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l2Oiuea+KA5m9hqd8bSg+iI1z7RZ71qgwzxTWYwiy0E=;
 b=zA9575AFeAy33yx9ihwPDCZ1FYtNrPrSc/hqYT5T8z+hdkhJvW0VN2fWeXGUE2Ss3n
 Ba9PuTb3LdPvrbfmM9FhF7e7PxIpbPq4l4BwtL0aSLBELDFnzk/6kNLH7k3R7NSiBDIk
 /k+bOCVSWa33lVAlZ5fNOLU2y6KRrCQhWKMT6h/xQccgG/C+Vejes3jFyu/MsSr8KHLO
 pRCzwN5lOBi6aKxDN/WWlL2IG7Fd00hQygSKkFeUQYI7SLYMSAfV5ozY7FdcmqPYDtHG
 PWNkqtVaQfjjabdqXwA24+EysgcF2v+gx2bRb6Z1awzkSiLwPHgNuN08DKBJaYH52ApW
 GjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795531713; x=1796136513;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l2Oiuea+KA5m9hqd8bSg+iI1z7RZ71qgwzxTWYwiy0E=;
 b=1j7h8SqBpfhbmGWIZscmCORcuiS4iTLCzAszu6dynVmb69wE57kX+xDJLX4ePLbldh
 fW7T4uNrEKrL8YK0xP3L03NwPUmPl/P72gsVFHGuD4zsAK1jt3n2icjZsohG3tePR8++
 jjOItk0fyj+wOVtwWp4DmL2W1FjhmjRMdgMq8Tm5gNfncU+0OTcYSMeTbh01I5ukp3YI
 9iLzYdxkzMRqiXAz1SL8l82bT0vatCK7iNYaoGFucguMIfXNhO+n1c+lkK+CLOHe5wTt
 Wn+6fYFVqSS397DTpqEfrwiabiTFxe38txsxbN+Q2a8wqhHVO0QggK9KBpRKWF01Auyp
 JCCA==
X-Forwarded-Encrypted: i=1;
 AL+hErFWonBDy/JFANC4Buk5fiyhgYiUXOcXEBEup8XQ1h9LEH3of8vqFDzkeTz3xwVRba7BKhqtr604qT0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9mItDqyHgda6X7i0be+ZtpETNknhrmehbFhWSBq7hOS8Sg6UO5
 38xpWTrcDrRuCdGA2fNjIq8cBG3S7/DcRdKURKLK0R5P79v/L7ratJE=
X-Gm-Gg: AZFdTZeUySPQrVj4A9FnQCQqgy+CPBs0ZKMUDbxCDGtI9QgSvs4wPkNA9+uVM9jQHgs
 oJRqMJqfxxLKVF9X7a459bNC0qYr2MdrSxn4qoKXHiBOms6HR1sq7IMq8HBF0FKGTDqe/fetHAg
 0Ux5lFOx2luDCyfkmhfFrQ9TriQMf5MMzqWvmxV0tu+C3TveAZm3HRO+K6E9yLVGVwStkWCdZlI
 dy9kc4gewzXvDto5+xDeKmpzGbol4qhs0UqoNJSFPuAB7jpuwECQ0i9Qw4fjMuh96NYi+hFRFMb
 OCS0H4chU8CnxLcA1rax1whh8l3ZEy//B/H9/srnxwvtJCa3Txf7R96uHQhwa27uypt9eLXc6ak
 EoNS+lVMpPuBgN0CYaQoTh/VlY4Ymel5S2fusWuxV9Bc9ZE3vJYUw46mWtrjfC9nRXWLXE2Q3c5
 KZbS0BjBx0A4Sjm1kWiV89sTu+LUxlakDLgySo6/dK4xbuIPS1Gy8u6wvBpEpIczmxvMGwhodAf
 hWGLPt33yC8ewPe34x1Cr6qS0xDe8pqhqrdLgY33SrQ0e+Lcb7jeml9P+Po3e8HPmKKNfzR9Nnz
 vqXDNjCjNsu6sEegbd2Pqte5
X-Received: by 2002:a05:701b:4553:10b0:1b2:6a1d:bf58 with SMTP id
 a92af1059eb24-1b55694435amr15016501c88.38.1795531713236; 
 Tue, 24 Nov 2026 06:48:33 -0800 (PST)
Received: from localhost ([2a09:bac1:36c0:1f38::1c5:14c])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5566c3052sm35544589c88.1.2026.11.24.06.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:48:32 -0800 (PST)
From: Murali Krishna <muralikrishna2444b@gmail.com>
To: anandu.e@oss.qualcomm.com
Cc: srini@kernel.org, ekansh.gupta@oss.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, jorge.ramirez@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com, rene@renesp.com.br,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Murali Krishna <muralikrishna2444b@gmail.com>
Subject: Re: [PATCH v4 3/3] misc: fastrpc: fix context leak and hang on
 signal-interrupted invoke
Date: Tue, 24 Nov 2026 20:17:43 +0530
Message-ID: <20261124144754.99753-1-muralikrishna2444b@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117-interrupted-invoke-v4-v4-3-2320a8a7eda2@oss.qualcomm.com>
References: <20261117-interrupted-invoke-v4-v4-3-2320a8a7eda2@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 15:09:47 +0530, Anandu Krishnan E wrote:
> The same unreachable-orphan problem exists for a timed-out kernel
> invoke (-ETIMEDOUT, only possible when kernel=true): the bail: path
> used to unconditionally unlink the context from fl->pending before
> dropping its reference, even though the DSP may still answer later.
> Leave it linked on fl->pending in that case instead, so
> fastrpc_notify_users() can still find and release it if the channel
> is torn down before that answer arrives.

I am new to this driver, so please treat this as an observation rather
than a review. I applied 1/3 and 2/3 to char-misc-next (917fcbf03) and
read 3/3 against that tree.

The -ETIMEDOUT claim does check out: fastrpc_wait_for_response() only
returns it from the kernel branch's wait_for_completion_timeout(), the
user branch uses wait_for_completion_interruptible(), and
poll_for_remote_response() converts its own timeout into -EIO.

My question is what then happens to such a context at fd close.

Once 1/3 removes the loop in fastrpc_user_free(), no path drains
fl->pending any more: fastrpc_notify_users() completes the contexts on
it but neither unlinks them nor drops a reference, and the drain 3/3
adds to fastrpc_device_release() covers fl->interrupted only. A
timed-out kernel invoke therefore keeps its worker reference, stays
linked on fl->pending, and through the fastrpc_user_get() taken in
fastrpc_context_alloc() keeps fl alive until an SSR runs
fastrpc_notify_users(). If no SSR ever arrives, nothing releases it.

The reasoning you already apply to fl->interrupted seems to cover this
case as well: if fastrpc_release_current_dsp_process() succeeded then
the DSP is done with the whole process, so a context sitting on
fl->pending should be equally safe to release. Would it make sense to
use release_err for both lists?

What made me look was that fastrpc_release_current_dsp_process() is
itself a kernel invoke, so it can be the call that times out. In that
case release_err is non-zero, the fl->interrupted drain deliberately
keeps the worker references, and that call's own context is also left
behind on fl->pending -- so fl, its maps and its mmaps all stay
allocated while fastrpc_session_free() has already marked the session
reusable.

That looks close to the behaviour Renê de Souza Pinto reports on
QCS8275 after an adsprpcd init failure, in a thread where he has since
offered to test this series on that board:

  https://lore.kernel.org/linux-arm-msm/20261124141843.3967523-1-rene@renesp.com.br/

If that offer stands, an adsprpcd init failure followed by closing the
fd might be a useful case to try, since it is exactly the path where
release_err is non-zero.

I built 1/3 and 2/3 on char-misc-next with COMPILE_TEST=y under W=1
with no new warnings. I have not applied 3/3 itself, and I have no
Qualcomm hardware, so none of this is tested -- it is from reading the
code only.

Thanks,
Murali Krishna
