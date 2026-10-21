Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9DF606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.a=rsa-sha256 header.s=fm2 header.b=IrhPgW7C;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=VoFcE4y0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 529DA10E1CC;
	Wed, 21 Oct 2026 10:00:40 +0000 (UTC)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E0C810E1CC
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 10:00:29 +0000 (UTC)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 6029FEC01DA
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 06:00:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 21 Oct 2026 06:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1792576828; x=1792663228; bh=a4qQqva7hp
 ZUYX8lZvn/7hBg+bhNuRpKHD2wnwR6pQg=; b=IrhPgW7CC9gnA/uuzKnQnH9l3i
 3BuDutwayG8ADMAiTtYFTaGvpqZn/6sOgylXVVMOXnDgSX68I1mRVrqw0FsZH3yj
 th7fje01BSrfhhkpTrCmEKoWRBS4GFBFtOtz0zBmev7uXS/oWPQSnHGCfmxIlr/+
 VzhU7wI70hYauCGdi2Bw8zisCeulG3b6pdT0oCNlYYLiltgcWVxffv9PPPlFuULM
 DjIxDzhNbch4AbpQbWmQB50CvYu3kbec+eyalZq0seiZpEBksD27s3WZujzcd5bb
 PNs1F7fy/yUbfcSFmY5DYUVXyTP4GqgAkG5DnAghHKponwYAJ6zOAZORJ3bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792576828; x=
 1792663228; bh=a4qQqva7hpZUYX8lZvn/7hBg+bhNuRpKHD2wnwR6pQg=; b=V
 oFcE4y0CigyTYFRLgk6apAcC2yZNg2YZTWBKM73jLMSdzoCWNx/hP1lVW578xqnH
 eQDPyd0gzqupAycn+yhLFW+GdtBfKFVim4XvtYTVSNCmW3BeHH/ipoZf3mVgV/Fb
 TAY6WRVwSCX1D8jGLpXUOH2XtHkjKRv3wtg9XvS/cYTKrvRlVHW9zjYumdeVeDyg
 905CnpUJwShS9/OgJq++VNWXKy0VFR1JbMOo0TgLuD6yumvvy4FGfSo/aj9ZEbny
 zXAp5ueF0tg6eD+IH1KQCruiJnZfvrm8EJqH7uHswukMTjNefMILRNmao6Vsyz5D
 SvSVh+wDXOT7Zs/eVS1cw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=invisiblethingslab.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792576828; d=invisiblethingslab.com;
 mf=PHZhbEBpbnZpc2libGV0aGluZ3NsYWIuY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm2:rsa-sha256:BhrMrHMmGMiIEX5828a9XlEqGbhyLyLiXLkgkFI4EmkqZkz
 PHR76h5F8kruQLbxvBxNAIlg3TKQsSqIgF60WcjW5pwuQuRscDL4qhWdOj/Uk9lo
 pgfLcjwUZaLP76eMO+xiTnJgk6shtGTYWkV2j2kJdyMRHyq++xEYxpHHkCz66nSF
 oSJE+yOa5eiSd9EBaiMVVmMMHYAam46yx8FvVWhgECli5ZUmvezD3unoniZBuFaD
 I6z9e2dJNJr9tX/Kidox318jz+x8XRUQ/D/6Z5S0EsmwdPyQygzMeRc2RZvghXzY
 6Tef+coyjtpapzgu0jBSSnxSwt076Mdge1rfZ4Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=15;
 hn=autocrypt,cc,content-language,content-transfer-encoding,
 content-type,date,feedback-id,from,in-reply-to,message-id,
 mime-version,references,subject,to,user-agent;
Message-Instance: m=1;
 h=sha256:sH61B0WTNd3o7Ce01Ay7b+0PcjVatBMKl5oRbnezMDY=:1T00oweYgELIabGf0R8/4TqhxxaGwwH2ImTdruNeOBA=;
X-ME-Sender: <xms:PI3YagHUcQnsOnNnhICLlqYgjX-C1sFVuzjtp2DBCoVYwAE4neiOow>
 <xme:PI3YahGupoFO_yw4XnLwNIV27UCU2MzO4c40qQTkdWrDaDAQLsUT6MRwUk-gHERik
 nMlr2fiEWWtZ2ESgZDVrxAJRDEuOBI6srMg-bP6MTPfAC160FcF>
X-ME-Received: <xmr:PI3YatPeaJS-xXqN0ErlT7qgkRxihqIH3v_gelYg2BiTmru6bvPDR7Vx2Mpn99kf83HhaM0ZF3YKu7XlKZZKSVe9xeqERZsJWA>
X-ME-Proxy-Cause: dmFkZTFxDuD5zJD64YygKVPOuOgENiIrImFPgMb6XrSrAnNLWLV7NYtdzfqIktQRdYMXTZ
 lHdjqOAkhdfRXEEwZPaOn5fjynGXLcdqlCRCv53c3rvcHdnsgiQsNkCtSH3WQlDc1EZbuY
 5Mi1Ub0jZqdxbzmySdn95CeBBNI++GKicx9Sw3D/Pj0/jqqKFSn1GsDMEWXoDqDGEdgT83
 v84jeCuOK78dXUXP6ZYqUtHcSQcGsye15T0Rwq7KHH/xYgVlGlWQN4rJueMb2FjQV8dJ7r
 QogUafA/q3iY/AsGBS/OthLolNR3N/x6r0tPXWZ6cXpfE0dZeq8SQFk9CkQPIa3FaOdjfB
 6cxDdeqLx+YwzA+Hmqshzqrqy8YX9h5gL+8Bd+CRpoP2HRW/60QFImoHbmTy2fwhJr7Rrr
 /Z2pdljhdxtSYpyKZ6mBTrvVFaKWMrd/4zn1CqLI5nrdEgS0J9d//f5vHqmoy9jvb3HfMF
 pvFrDER5PhLYhVaLkDFJ6adST9mI19XKo+GpYfAVYm2Y5FalnRbd2R+sZUcLYXICpAOMmi
 FhcvhwVabkNZqSR2AckpedJVg/Esm3FM+pSV1P9jtPWs+bjjn2338eoK9D1rTV6gzxFiTl
 Ug4FH7T7gWsup6wRkccLy9184YxM6gD+xocHKnG4Ln4LMpYadXnJh7wuD2CA
X-ME-Proxy: <xmx:PI3YagHz7ddGXSuPAUGJbhVlftPI-giYKhNBSSsta6ff4vCVPB65bQ>
 <xmx:PI3YakNnYgkcyciwBgx8DceX8DUJt1vdu5JzbW3rBUS-cUOrBBc3EQ>
 <xmx:PI3Yah_qnhZbmJepU3LIJHMb9rgJnV_3D1h6amALKhmAGv8GbJhLtA>
 <xmx:PI3YagSXf4yBXYWD-tjD_kdOsF1iUNC9IG5Y0ZcqVx5owyhfm4q4lw>
 <xmx:PI3YamY9qmGcDB2hO7YwA6FX4bNYKQGsI8iKK-ANKuFbglF3mUvA1r41>
Feedback-ID: i001e48d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 06:00:27 -0400 (EDT)
Message-ID: <3a69039d-2454-4693-b99d-9208694709f3@invisiblethingslab.com>
Date: Wed, 21 Oct 2026 07:00:24 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: Add DMA_BUF_IOCTL_SET_RELEASE_EVENTFD
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
References: <20261021093533.1990028-1-val@invisiblethingslab.com>
 <sashiko-outbox-180068@kernel.org>
Content-Language: en-US
From: Val Packett <val@invisiblethingslab.com>
Autocrypt: addr=val@invisiblethingslab.com; keydata=
 xm8EaFTEiRMFK4EEACIDAwQ+qzawvLuE95iu+QkRqp8P9z6XvFopWtYOaEnYf/nE8KWCnsCD
 jz82tdbKBpmVOdR6ViLD9tzHvaZ1NqZ9mbrszMXq09VfefoCfZp8jnA2yCT8Y4ykmv6902Ne
 NnlkVwrNKFZhbCBQYWNrZXR0IDx2YWxAaW52aXNpYmxldGhpbmdzbGFiLmNvbT7CswQTEwkA
 OxYhBAFMrro+oMGIFPc7Uc87uZxqzalRBQJoVMSJAhsDBQsJCAcCAiICBhUKCQgLAgQWAgMB
 Ah4HAheAAAoJEM87uZxqzalRlIIBf0cujzfSLhvib9iY8LBh8Tirgypm+hJHoY563xhP0YRS
 pmqZ6goIuSGpEKcW5mV3egF/TLLAOjsfroWae4giImTVOJvLOsUycxAP4O5b1Qiy+cCGsHKA
 nCRzrvqnPkyf4OeRznMEaFTEiRIFK4EEACIDAwSffe3tlMmmg3eKVp7SJ+CNZLN0M5qzHSCV
 dBBkIVvEJo+8SDg4jrx/832rxpvMCz2+x7+OHaeBHKafhOWUccYBLKqV/3nBftxCkbzXDbfY
 d02BY9H4wBIn0Y3GnwoIXRgDAQkJwpgEGBMJACAWIQQBTK66PqDBiBT3O1HPO7mcas2pUQUC
 aFTEiQIbDAAKCRDPO7mcas2pUaptAX9f7yUJLGU4C6XjMJvXd8Sz6cGTyxkngPtUyFiNqtad
 /GXBi3vHKYNfSrdqJ8wmZ8MBgOqWaaa1wE4/3qZU8d4RNR8mF7O40WYK/wdf1ycq1uGad8PN
 UDOwAqdfvuF3w8QMPw==
In-Reply-To: <sashiko-outbox-180068@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/21/26 6:47 AM, sashiko-bot@kernel.org wrote:
> [..]
> Can concurrent DMA_BUF_IOCTL_SET_RELEASE_EVENTFD calls on the same dma-buf
> race in dma_buf_set_release_eventfd() in drivers/dma-buf/dma-buf.c and cause
> a use-after-free or leak of struct eventfd_ctx?
> [..]
> What happens if more than one process registers a release eventfd on the
> same struct dma_buf, or if a recipient of the dma-buf fd calls
> DMA_BUF_IOCTL_SET_RELEASE_EVENTFD? [..]
> Could that leave the original waiter blocked indefinitely waiting for buffer
> release, and would a list of registered eventfd contexts (or rejecting
> re-registration) avoid allowing one holder to disarm another's notification?

Yeeeeeah I guess a "one use only" policy would be better after all, i.e. 
not allowing replacement. That should solve both of these. I'll probably 
change it to that in v2.

>>   /**
>> diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
>> index e827c9d20c5d3..566dea778ad06 100644
>> --- a/include/uapi/linux/dma-buf.h
>> +++ b/include/uapi/linux/dma-buf.h
>> @@ -179,5 +179,6 @@ struct dma_buf_import_sync_file {
>>   #define DMA_BUF_SET_NAME_B	_IOW(DMA_BUF_BASE, 1, __u64)
>>   #define DMA_BUF_IOCTL_EXPORT_SYNC_FILE	_IOWR(DMA_BUF_BASE, 2, struct dma_buf_export_sync_file)
>>   #define DMA_BUF_IOCTL_IMPORT_SYNC_FILE	_IOW(DMA_BUF_BASE, 3, struct dma_buf_import_sync_file)
>> +#define DMA_BUF_IOCTL_SET_RELEASE_EVENTFD	_IOW(DMA_BUF_BASE, 4, __u32)
> [Severity: Medium]
> Is DMA_BUF_IOCTL_SET_RELEASE_EVENTFD in include/uapi/linux/dma-buf.h intended
> to take a user pointer to __u32 or a file descriptor value directly?
>
> Here DMA_BUF_IOCTL_SET_RELEASE_EVENTFD is defined with _IOW(DMA_BUF_BASE, 4,
> __u32), which indicates a user pointer argument [..]

I don't see anything in include/uapi/asm-generic/ioctl.h intended for 
defining value arguments but it's a common thing across the tree..?? :/


~val

