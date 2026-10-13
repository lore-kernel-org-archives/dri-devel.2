Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C38CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F6DD10E837;
	Tue, 13 Oct 2026 13:08:01 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0AA910E839
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:07:54 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-49e09a20082so1629871fac.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 06:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791896874; cv=none;
 d=google.com; s=arc-20260327;
 b=V/sn9ssDdkiEFkqSVbF1CX6vowO2u1lw/2lzoZsI2BgFxbgFC3J6nrk3c6wbcKq2NT
 WJVO5Bfqbjm9kt8CpWUPP1VhOUwwVqV83SpTuYFMhCSxibZ7miJY3iRK8S9L+c6OyYbi
 CvSDFVgrVcNNkulLW2NS53OVGQeykzsmzmaSMhrCMhdQtM7UMyINI3krxXAJwDfw69Xq
 j/B5TZXE53EXNyQ4HFmHiXzpWkKj7eYFkKGapb8x9PZHevFp2e/F2pqaSDohOg1sAyMc
 TiWB6GRYt568+91wG3OWjMnZ0PHYEV8saKpPV2vGNlIJcsMVB0UrWvwvAL+K5geCTiCJ
 QAYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Qheg1l+96cWqmrxCXMlwjyQaZbPfzvAfZfTwXsDXnnc=;
 fh=iIfmz3BIijL6BOsMKNq6GtWj38luR2KrNgxVDOKaN70=;
 b=R1UXa3N4mr3vY3f9P6FowVjKQ5pH0loRLvtlFyHjLoLLPV5FtXOsplrMkx5c6zLYXJ
 IVYJKg282T9Z0uaTIbw8aac4yAeWBsfPtYYWDsrIui185C5DXjtMIN6s1q7h9W70qi2t
 4ce2CDIJ/TpgB0OxC0BsOTU+4J42ltlzXnqhhb3Do22sZJqcSck2GnxlkKvSSz1FD3EH
 Kw8bZzHaEiEDcpZNFc9yqWBxz7P1jHlqcKyByyAsQKcPdhHL6sb5C/YPRwNTd5ZYYli3
 gvMP/WA7++WSy7CK2pu9AFIqT2v7kChlauYUts/Cx6e/+yvCcPKt4KV2JmBAJPQgs5LW
 9miQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791896874; x=1792501674; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Qheg1l+96cWqmrxCXMlwjyQaZbPfzvAfZfTwXsDXnnc=;
 b=FKOfPXvFa66pRSPhhwX9YmhundpzIJRR0+DESjoVupJQgedx3viBv35zF3TciI7+0P
 uQir/15+jGTTypKavdP7W0Bl49cANvzyObla8I2sVY7rZjvHbkpHy95qZ5CL+pRHTLqC
 wIb4UcGs2LbLLmHe3L1ef9K3xQP00cjk/c0RipPzrAFaBeiIbcAlNdaDVxW+i9qdE+c5
 hfcelmrP8+Zkq9C9CD8iQMRnT1NsgVK305bNyavgXK5Vg0OPPK6qloIpoNtqQjT5agPc
 ggQMFphapoN9FUvcY6nh6eBWM3WvQ+/y9pmlDnhDrtrxh3gKLJZkh0PmFxntu3broYoB
 ZZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791896874; x=1792501674;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Qheg1l+96cWqmrxCXMlwjyQaZbPfzvAfZfTwXsDXnnc=;
 b=waSyTrKfYGKfkciWaz3ye+YWTIsRrSMgCDfzpRTj1zzrPIQv3b2a6Wj+nq/qXZ2Kfw
 YaW9bwuodMRQ08JUcsj6JvoZlSLVI5aOJEd27lMJ0M7oKHHyaqIXV8GFG7H0vtIDoqwA
 D/cwze216yY8aF0YLbqEYsNZDYb0jyuPC+SXbOFEjEO9v9VKaaKIG9GVzTwClCJEBz4t
 kPLe7gx3NlHZjXxgwJpJHiiIj4QWopyij/WzWfVJcTmSQqGxrmdQme47p7HjuzW25UOV
 ZITAk8BYmchouUbG55lHHnPmPUXOyLMhrr04WwA6RvNqguTu5SPUm5C4AEl1SewCVFIe
 XpLw==
X-Gm-Message-State: AFq9FYLUmw4ZTf6BXHvKZgA8zt2oiRthDk3JeI/GIeoG6HxGMpv6PRpA
 9UbpA3sVgT8g1si921EomIyStQ0oMK91CndrW33wqqD+Aat1t8PJEqVaX2lGjOG9zC7xaPuf1dQ
 P12EwxQlpWKSW5HW6EF/ISTWJ5CMLn7U=
X-Gm-Gg: AYBFou3I7vRljYlYdhzMab3TZJf5cv9qAALDScLS32FlhgOD1pYJE8nGGS5bvOjHWmF
 nyssSR8HywhIKa1XiA5928pOCV+Zybtu10sTJcm/IFYiIIWXdf0ZAJnIfA4RhcIJt16XXqB5w2C
 LTer7JsUD5yIzHuXg2EpmCT+XKnZNDuiLeNhoQ5MBUmEFyUq+kIamgx92A8X3wMu42BzxpwPasx
 d47PWy9v9HbOaML2TvHPU4+UlQ3aigPxWt1Xm9rsSe+SJwjh1urhljWF4vimcKua87Iqw7QIF0s
 KQ1C/Bsi0bNVK8CuX/GsAUWSShie05WdxMjp00DMDMmAHUo0i55kSmfiRe9l99kGjPcZv5sApyz
 lILrpg4n02kpDMg==
X-Received: by 2002:a05:6871:385c:b0:494:75ba:c6d2 with SMTP id
 586e51a60fabf-4a2a895588emr10792549fac.13.1791896874028; Tue, 13 Oct 2026
 06:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20261012170857.199561-1-hjf3108@gmail.com>
 <64707239-eac7-4259-a8ff-7ec43d13860e@suse.de>
 <CABOQOSXgG2kBzs2sBEE69mmPcO0cKVgjyk_6DG5RST_4uL2+sg@mail.gmail.com>
 <c9460a8d-3fdf-439f-9655-82b60617b85c@suse.de>
In-Reply-To: <c9460a8d-3fdf-439f-9655-82b60617b85c@suse.de>
From: Jie Feng <hjf3108@gmail.com>
Date: Tue, 13 Oct 2026 21:07:18 +0800
X-Gm-Features: AclHuK_BSShDGM_0lhA2qLrS0hd1Dfj-OXXVUtwJLUikUL0Nv1qjZuflxKv6ilA
Message-ID: <CABOQOSUE17pQQYydLxCLHg1Jg90dwCEvMZYyo6TzYHMn9RAL2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/format-helper: Add XRGB8888 to UYVY conversion
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 13 Oct 2026 at 20:32, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 13.10.26 um 14:17 schrieb Jie Feng:
> > On Tue, 13 Oct 2026 at 15:11, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >> Hi
> >>
> >> Am 12.10.26 um 19:08 schrieb Ho Jie Feng:
> >>> Add a helper for devices that use packed UYVY but accept XRGB8888
> >>> framebuffers.
> >> Is there a description of UYVY available somewhere?
> > This is for a reverse engineered usb display adapter, which accepts
> > input in bytes of U, Y, V, Y in that order. I'm not sure what
> > counts as a description, apart from it matching DRM_FORMAT_UYVY?
>
> I see. The format exists already in DRM.
>
> >
> > This patch is meant to move this out of the driver:
> > https://github.com/rhgndf/ms912x/blob/main/ms912x_transfer.c#L153
> >
> >>> Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
> >>> ---
> >>> This is used for a driver, ms912x that I will be submitting. It only
> >>> supports uyvy framebuffers.
> >> Please resubmit as part of the driver series. We're not going to merge
> >> it without callers anyway.
> >> ...
> >> For naming, please follow the conventions used by the other helpers in
> >> this file.
> > Will send the driver in with this patch and its fixes, thanks for the review.
> >
> >> ...
> >>> +             v = drm_pixel_rgb2_to_v_bt601(r, g, b);
> >>> +             u = drm_pixel_rgb2_to_u_bt601(r, g, b);
> >>> +
> >>> +             transfer_buffer[dst_offset++] = u;
> >>> +             transfer_buffer[dst_offset++] = y1;
> >>> +             transfer_buffer[dst_offset++] = v;
> >>> +             transfer_buffer[dst_offset++] = y2;
> >> Rather that writing bytes individually, use put_unaligned_le32() or a
> >> similar helper.  Byte order within a pixel is little endian, although
> >> I'm not sure what this means for UYVY.
> > This is meant to be sent over a usb transfer, so byte order needs to be
> > the same on both little and big endian systems.
>
> DRM formats always refer to little endian. As it is implemented now,
> it's not clear what the endianess of your output is. Please duplicate
> the other helpers' logic. They all pack the output with appropriate
> helpers. If the USB device requires BE, you have to write a separate
> conversion helper for that.
>
> BTW, you have an OOB access if the line width is not a multiple of 2.
How should I handle this? Rounding it within the helper doesn't seem
to make sense and the function return is a void, so it can't return -EINVAL.

Other helpers ignore the -ENOMEM error when drm_format_conv_state_reserve
fails, so should it follow this convention?

Alternatively, drm_fb_xfrm can be exported, and let the driver define
the rgb->yuv coefficients? But I think it is fine since _to_gray8 also
cites BT.601.
