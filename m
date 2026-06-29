Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655FEC43638
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF93A10EB46;
	Tue, 30 Jun 2026 07:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ifaenfxb";
	dkim-atps=neutral
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64B2A10E8E0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:57:01 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-80bb8287d99so30670457b3.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782741420; cv=none;
 d=google.com; s=arc-20260327;
 b=fdAWbJhqMi2kuLsPbeLGxMTUlrfPJRvbjE+yWrw070AgIvgtOF/6QlftI7Ru8V8cRT
 vylOscAX/raZkSgKHgO/PtmLWkDVyT2DpHZqAgkEaN+JK68+zcrpK9xkr4xUHoSz76eT
 vQcX/YC9oLmsdoWVb+V+tPXAM7YmNNuL/JcJgolLao5piJrWqY0t6+uBBY6p51f3ePKk
 r9XoFSLlzZw6sd9vkC8b+7EJXWBSoJExpKMZiJgNH1mIgV0QR1lC0NrDZHFRKEryRVXp
 FX1i20Ds5EEwjVg+BkLm1oNxOQhZEpXFPQLoYkDwh4yuRZAdWso7H7DBu1NyjyA8AtSc
 1JMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:dkim-signature;
 bh=GgwHmQNiGftfM4Rvb8+WbihD7Vl9XT13f1KvcgOYD/4=;
 fh=55xtU6GSLmwfcXray4dqq4CHGxCshzp9myPcgPVRle8=;
 b=Nb2qqLIaPMzDX7IyBWLEwUUWr4DvwswfPo36fl5NnQhwmXzdcMO9AtPXq23SuwomLx
 cd63S3rBJ4+Gyc5e5lMzrWAp+r5buYTS3N6bn0Z9h83Ade5pFv6AemjZRATOwT6kopOT
 ekldC+BUbUBaI0USvXWVwrNGjkdwgPp2Ab1h0yirBk5iICEzs6+3nGW8Y+4CAgCMsO3R
 Vzo1Qv5zC5mmixBaZHmFp7Mxx35u9ZmJekYHHz1JnaqrKAEap6OTI3m0/Pq4DBMF29Tg
 aiEOrGMPLDUBteoqycE3gvxSMLXdZSxmF27R0s9b1P32dBpCfRLRo9mLQEA/kHWveE4G
 KA1A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782741420; x=1783346220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GgwHmQNiGftfM4Rvb8+WbihD7Vl9XT13f1KvcgOYD/4=;
 b=ifaenfxbuypCxdYbmNMAyRH3xUSRGtpiiDcsZaa3DoEb2PM9Y7FTCexWFiVVkaK4di
 IRWl9Bv+YQNikIgGXVr7jOaql0d9DkZBTr1GD+E+QxcjobWAyYKd1WtfKZUDSD7f6YtY
 9zqw+9HASwaifyUl4YU789kar4tGa73QLtgaDDWH6hF1tVc1GO87QNPSnVbCJQVs0EYn
 BtFhZf1aRY1TNQ2YAf/+KYOHQ2/QkM1FyIPf7KvADWGIOSGs/0e6/CwotSSL7S/FB/jm
 E4EwZbtSpU7jB7GeDtKM1VhsntNnefDFyICpAgKIsc2kf8KpbSEsHOQxkP93GmhXfVEo
 puYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782741420; x=1783346220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GgwHmQNiGftfM4Rvb8+WbihD7Vl9XT13f1KvcgOYD/4=;
 b=QCaroNxzHqox8Xrc/HXWTZHAJ3GAyyf18dCfBbnV+KVFL8c35RjAKQ8ntIK9X0du/W
 eY22m3YwJ6sJ3QTLUKh315p9YbZMxJdJ4s4fWq1XJ7iF8/i89f/HbHZGaByCSN859bwz
 HO3KSyogJneV4ttT1bKu/yBd3qc1f1VlMBdzfjuxPw0WCmV5owG1mbkrCz0nP8mXqKhM
 /Q925t0N5+hkNtu4Bt1p6/SOUzVF+Mv/S4RqEWmCU1sLlxSnQMoa+KGfbL5NPEDLXeAy
 RFdXWFgIQfvIZoGpEAYE2KrdD4yeGWWWPrc9nu9c9JADSTweMaBm6osfof2ctm9M21Lb
 uTaw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6Hofy/BTPJ7v0q0ipPFw/xyshzTnDR22Ta770tyfs/AIvEFbiNecLGz0VIXNdLmdT4GeKNo2oWew=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywf4NaYc48zI7qgspbGvlaz73Ybj4d8puD5nWpCtcM3GMhHxkAu
 QmWkfCm57MKJK+B+dwbnf2PMYQh2/2JwgYse34ZbwEkkXpkSEYBc+1znlP8T4bKCbpJVtnDE0Gu
 kjtbLno7KxU5uTbXfmbVqT931XV/gPds=
X-Gm-Gg: AfdE7ckAL4iMR8wwoKe16q3CPnn76MQom3mx2L8swTbTe98kZIy3pLyqcpg4YN0sxJX
 tffx+3CBmrod8RJyPxMYOW3eatOMD+1u/24NUI2l/K5EX/40KKqHRXsJa0a10QANURKbQ+XiACs
 8z9g1k20K36DoPI++IkH2GYGIdg94gLAEsOXYR0IMCMtIwJ31eGroPg66xPu+4Sycj1VwiTI+LI
 XZVxnxVoOTXFNXEXQXenV0PIeHXfiNnEpSBCgpdxWYo6i6C50W33EGLfGtGFnOOPXEvWcuBaoME
 Nm8u26E=
X-Received: by 2002:a05:690c:6386:b0:80c:85b6:75be with SMTP id
 00721157ae682-8109186d88emr5241967b3.71.1782741419655; Mon, 29 Jun 2026
 06:56:59 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 29 Jun 2026 08:56:57 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 29 Jun 2026 08:56:57 -0500
In-Reply-To: <63537951-2c16-4ce0-ab8a-067315833bac@amd.com>
References: <20260624172029.2508-1-alhouseenyousef@gmail.com>
 <20260625135341.1159-1-alhouseenyousef@gmail.com>
 <CAMuQ4bWVb-vxCWMxF_JpJmBnKD=rVH2KZWf36jnzPbC35CdrmA@mail.gmail.com>
 <63537951-2c16-4ce0-ab8a-067315833bac@amd.com>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Mon, 29 Jun 2026 08:56:57 -0500
X-Gm-Features: AVVi8Ce95FJU1tUzW1L8s63UJlluxab-3LuvsLRAn19TFAa3RcTbRjB_TqHo-4k
Message-ID: <CAMuQ4bUio-XcOTDMY6r+Momg24uy7j0UXT=Bsk85jTbvjiCN7g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: reject mapping info when BO VA is gone
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 30 Jun 2026 07:19:13 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

No, you are not blind. I generated v2 from a local branch that still
contained v1, so the v2 diff added a second check on top of the
intended one. I then mistook that local state for the target tree when
withdrawing it.

The close-handle race you identified still calls for the single check,
but neither of my postings is suitable as sent. I will prepare a clean
v3 against the target branch.

Sorry for the confusion.

Thanks,
Yousef

On Mon, 29 Jun 2026 14:33:37 +0200, "Christian K=C3=B6nig"
<christian.koenig@amd.com> wrote:
> On 6/25/26 16:26, Yousef Alhouseen wrote:
> > Hi Alex, Christian,
> >
> > Please drop this v2 as well.
> >
> > I rechecked the target tree and missed the existing !bo_va check in
> > AMDGPU_GEM_OP_GET_MAPPING_INFO.
>
> Am I blind? As far as I can see at least the code in drm-misc-next doesn'=
t have such a check.
>
> Regards,
> Christian.
>
> > The close-race case is already handled
> > before the mapping list walks, so this patch only makes the later check
> > unreachable and changes the errno.
> >
> > Sorry for the churn.
> >
> > Thanks,
> > Yousef
> >
> > On Thu, 25 Jun 2026 15:53:41 +0200, Yousef Alhouseen
> > <alhouseenyousef@gmail.com> wrote:
> >> AMDGPU_GEM_OP_GET_MAPPING_INFO looks up the GEM object from the file
> >> handle and then locks the object and VM before resolving the BO-VA. Th=
e
> >> GEM object reference keeps the BO alive, but it does not keep the
> >> per-file handle open.
> >>
> >> If a racing close drops the last handle reference in that window,
> >> amdgpu_gem_object_close() can remove the BO-VA before
> >> amdgpu_vm_bo_find() runs. The ioctl then walks the BO-VA mapping lists
> >> unconditionally.
> >>
> >> Return -EINVAL if the BO is no longer associated with this VM.
> >>
> >> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> >> ---
> >> Changes in v2:
> >> - Describe the handle-close race instead of an initially unmapped BO.
> >> - Return -EINVAL instead of -ENOENT.
> >>
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
> >> 1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gem.c
> >> index 212c14d99..6f5b6f4c2 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >> @@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev,=
 void *data,
> >> struct drm_amdgpu_gem_vm_entry *vm_entries;
> >> struct amdgpu_bo_va_mapping *mapping;
> >> int num_mappings =3D 0;
> >> +
> >> + if (!bo_va) {
> >> + r =3D -EINVAL;
> >> + goto out_exec;
> >> + }
> >> +
> >> /*
> >> * num_entries is set as an input to the size of the user-allocated arr=
ay of
> >> * drm_amdgpu_gem_vm_entry stored at args->value.
> >> --
> >> 2.54.0
