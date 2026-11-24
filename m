Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038D606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=02APOJbE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1FE210E4A8;
	Wed, 25 Nov 2026 08:41:20 +0000 (UTC)
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com
 [209.85.160.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 561A410F693
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:23:31 +0000 (UTC)
Received: by mail-oa1-f67.google.com with SMTP id
 586e51a60fabf-4b5138f0991so2759888fac.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795530210; x=1796135010; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zn2B+DmPBbx5TpMchnmfzNC5AyyLvagXfE8qQeZUWjs=;
 b=02APOJbE89Nwo0MfkfmNyJSCP1x+eGwK3z7wAAaO8O+cj7YabMTFV8JQ4+2Yx0T+37
 5cZHx4BclgWU1uoGbJL0bLIlC0s7Mbq80R9bkZ2JK9diunw4+WaCfBFaLPdQ4q/fOK5r
 AmmFpOOXTrS5EiDgHF+vN5syDVCgMJLQIA/NwUtqWKOou6rZkS2PU8P+pU3w7/Lpwo9c
 6ab8nAtyeARLsG6VjksQBTdc54kOrEfKyDlyWO3CGU7A8TyI8vgOik+swL8mouC3Cr3I
 FZwhm4n6I7PSW2FU8tkgbfJt0dwkapeRy+uL+J+5tIO2icUzImHreB8QR5LKfUTwTfCW
 inAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795530210; x=1796135010;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zn2B+DmPBbx5TpMchnmfzNC5AyyLvagXfE8qQeZUWjs=;
 b=al7FIeLkDdw1ekVxIYouO/6Wxv1QipeWzEnljAfjT9dkaMv6f3XFyMKKi6d5CEoWPq
 8sdg6b8gXWKwsTX7TEMJpPvmXWzwG7JCCtvAu+y/kZVjcn13B9Ib4rQ9NzT2vGH8ik5c
 +zv8Xxx6yNMkkUFrxCl6CHiCyf7NZkZPoltn/IlUjKqu+CLxGVCZXMmSzIuU7gRaGV3i
 9K3QeywLf7PGVAM2EW4cBOA8KEdKrXmiLk1gSy/bBYhrOMtC2S6YOSngZTUZRzOiV1LM
 r1eK4kxbNKhTC8cSbmd3uBNQ+lavtw9nmKajEx1NiN7uWF/3IoiUPyY7eKajvJOHU/dn
 Sy8A==
X-Forwarded-Encrypted: i=1;
 AL+hErEP7xTJpgBnKtLB931RL6JPo7BZx6xttzePkw9lSY+T3h9G5qZARtzV9dpt5z3iyVfyr8+SZDKuOFk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+lQsrmS/+QE7mfrLyQqiIcVrNZXWIb5BMPupWHOyupsKVEbQMG
 ZrlMTiPCPK3RirAWekPQXkGnQH/LuCaTukEGgzOxyTH3J+IPya0MsQE=
X-Gm-Gg: AZFdTZcKf0h3tSrPqa2z7L8hUWTkrb7eabYtYLaXPt1+Q9c1dmnoU82DlPiZCsVMxBn
 odJMpEsexDwlmAjCQGaU8TFTi1UndGlPKMFnK817Mbo1o6iH5TyR+4GJhAoRYmNNugtsAmhWIcH
 R2aYPj/gD31jER4Eps7zHG4AzIh2Twtnfi4rMNLzXWkO0fJYUqmW4+DAO6IYytnrpSC6QMvLdnB
 H5Ga4nGnX2O9vbYRUSQXgfHoKUj+/xS73efskP3kpdn1RY2IQsyhG8hLBBSe+/XUTZ4BZNiopjY
 d0tRMLIXTYayA3gBSPR+Ak3jE2L6WQmg1FLMvqcULhVBCvCTWIZTH+FhSl0xPbs4ghVCNWgMij4
 dJO49RqIoqOA06ToYIxOeLR3NCAE2awr8voJYKMUteqW9dSG4K3/hp+JYpjJSIRIayEywK463BD
 r/FgEVOP+3jjakvMk7cBEVEwKr6ndWCVIkBQOQj0pJqbEiU3XsT+/QdMPJ4Cj5dowwY11mFWpo7
 HfcvXZbueuosL9AJtdxMaS2QIF9tPNbRDphgSC3ri4AA92HEBxAbMCGP7QP6TniPRX+iCR56S+Q
 ZA0jZ59Xdc8SK8dYFHQFpN+vNw==
X-Received: by 2002:a05:6870:f62a:b0:498:8e03:c1e0 with SMTP id
 586e51a60fabf-4bb3bf60561mr10886373fac.40.1795530210118; 
 Tue, 24 Nov 2026 06:23:30 -0800 (PST)
Received: from localhost ([2a09:bac1:36c0:1f38::1c5:14c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60891cf6sm15090906fac.13.2026.11.24.06.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:23:29 -0800 (PST)
From: Murali Krishna <muralikrishna2444b@gmail.com>
To: rene@renesp.com.br
Cc: srini@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de,
 ekansh.gupta@oss.qualcomm.com, anandu.e@oss.qualcomm.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Murali Krishna <muralikrishna2444b@gmail.com>
Subject: Re: [PATCH] misc: fastrpc: fix fastrpc_user leak on abnormal process
 exit
Date: Tue, 24 Nov 2026 19:52:23 +0530
Message-ID: <20261124142229.88456-1-muralikrishna2444b@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124122011.2912030-1-rene@renesp.com.br>
References: <20261124122011.2912030-1-rene@renesp.com.br>
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

On Tue, 24 Nov 2026 13:20:11 +0100, Renê de Souza Pinto wrote:
> Since commit e85eb5feca8e ("misc: fastrpc: fix use-after-free of
> fastrpc_user in workqueue context"), each invoke context holds a
> reference on its fastrpc_user, while contexts left on the pending list
> (interrupted or timed out invocations) are only freed by
> fastrpc_user_free(). When a process dies with invocations in flight,
> this cycle leaks the user with all its maps and buffers.

I am new to this driver, so please treat the below as observations
rather than a review. I read the context lifetime in char-misc-next
(917fcbf03) and it does appear to support your description:

  - fastrpc_context_alloc() takes fastrpc_channel_ctx_get(cctx) and
    fastrpc_user_get(user), links the context onto fl->pending, and
    kref_init()s the context.
  - fastrpc_invoke_send() takes a second context reference for the DSP,
    released by put_work from fastrpc_rpmsg_callback(), or immediately
    if rpmsg_send() fails.
  - fastrpc_internal_invoke() unlinks the context and drops the first
    reference in its bail path, but only when err is neither
    -ERESTARTSYS nor -ETIMEDOUT.
  - fastrpc_context_free() never touches fl->pending; it ends with
    fastrpc_user_put(fl) and fastrpc_channel_ctx_put(cctx).

fl->pending is referenced in only four places in the file: the
INIT_LIST_HEAD() in fastrpc_device_open(), the list_add_tail() in
fastrpc_context_alloc(), the drain loop in fastrpc_user_free(), and
fastrpc_notify_users(), which sets -EPIPE and completes waiters but
neither unlinks nor drops a reference.

So for an interrupted or timed out invoke the first reference is never
dropped, and the only other place that drops it is the drain loop in
fastrpc_user_free(), which cannot run while any context still holds a
reference on fl. That matches the cycle you describe.

Two things I was unsure about.

First, this looks like it overlaps with Anandu Krishnan E's series,
now at v4:

  https://lore.kernel.org/linux-arm-msm/20261117-interrupted-invoke-v4-v4-0-2320a8a7eda2@oss.qualcomm.com/

I see you have Anandu on Cc, so this may already be understood, but as
the two fix the same leak in different places it would help to know
which is meant to land.

> No thread can be in an ioctl on the file at release time, so drop the
> references of the pending contexts there. A context still waiting for
> the DSP response is freed when it arrives.

Second, about the symptom in your test report. If a context is still
waiting for the DSP, the put added here only drops the first reference;
the DSP reference keeps the context alive, so fastrpc_map_put() on its
maps runs later, from fastrpc_context_free(). The maps are attached to
the session device (dma_buf_attach(map->buf, sess->dev) in
fastrpc_map_create()) and the attachment is only torn down in
fastrpc_free_map(). fastrpc_session_free() runs immediately after your
loop and only sets session->used = false, so the context bank becomes
available to the next process while those attachments are, as far as I
can tell, still in place.

Does fastrpc_release_current_dsp_process() above guarantee the DSP has
drained everything by this point, so that case cannot occur in
practice? If not, the window you are aiming at would seem to remain for
genuinely in-flight contexts.

> +	list_for_each_entry_safe(ctx, n, &orphans, node) {
> +		list_del_init(&ctx->node);
> +		fastrpc_context_put(ctx);
> +	}

Very minor: after list_splice_init() the entries are already off
fl->pending, and list_for_each_entry_safe() does not need them removed,
so the list_del_init() looks redundant.

For what it is worth, the patch applies cleanly to char-misc-next at
917fcbf03 and builds there on x86_64 with COMPILE_TEST=y under W=1 C=1,
with no new warnings from either gcc or sparse against the unpatched
file. I have no Qualcomm hardware, so none of it is runtime tested and
I could not reproduce your leak; the rest is from reading the code.

Thanks,
Murali Krishna
