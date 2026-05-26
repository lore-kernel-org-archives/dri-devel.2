Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2609ACD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FFA710E4C4;
	Tue, 26 May 2026 14:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eSemOEIH";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD9E10E4C4
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:15:33 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2ee4e75bc93so909975eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:15:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779804933; cv=none;
 d=google.com; s=arc-20240605;
 b=MqkLFxLPl263sfwKHVzX9vIBGCMw/RKnAL8vfLn4hK+ZklZK3m+8L+vpBpNl7gfsWX
 RyS+XNQc8ERJ45oz4LzUBsHzt2zSp6GJo4y+yWGldOp7wxDeM59yaJLcSC3IDlGiCpwr
 ZJmwPV7hhGG+MxA13lwn6K+0aqLEVivCsIuqGP70g1Z1F89vSOp3ANhI0JhJyWYMTUAq
 0+D3K3WcZzLblV/ztRfCNMvO5afLwRNQ4SbgjreT8KRFRpReU8aNDhtZkfFWkyxEIMVZ
 YHxhV+81dgOPnkkvlklWONRWcHy2JQs6QmPije8va3/eBi28S3U+cOhyKugKFwy7KRs3
 qmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pDEhYyW2dJMi85Y1zStgUw0dqF6oniUn/APg9Dgbdro=;
 fh=kyFZehDpHDjm7J6GommeuwaBy4MCfYbMQIBrFdr2pKg=;
 b=JG2uPCmGsTpz0H0ojvOhVDHyNQjZ5OggwEgBCmxm1NrDyrQT8ZemRljpJ+kKGlL1eC
 5DDjipehCyXJId2TsMEt55/hrY2Fjclpnb3kY8WdXb/lzJ7UM+ksu3Ohj/HzZ4XWD1AM
 QAFb9+D8b+obbx2P4U14h3X1n1RiajaRUTfVpurNkR4KgAb6INBPkMFkR85ROqIqHFPD
 pYvlNcmetdXiCbKjLkC2g5bxEleWU4EGL7yvBgBhGA8nn0SPl+7wh4GKQcJzY7ngctJN
 IFayqccnIn/JklHQmo3mlR+v2wZIb2KdJcVvILfBli9LNtfR5i/jtOf8Eamllt0VvvhT
 oufA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779804933; x=1780409733; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pDEhYyW2dJMi85Y1zStgUw0dqF6oniUn/APg9Dgbdro=;
 b=eSemOEIHzoTsRnZXP/ZWZWTJAh74l09/uX35xQHxYuQyi4z9HUrk3ICx+YrCUhyS5y
 0zjCPAwf8eOv+rGDlKt60E25/pBUwxMz/ZpYniDupM54U4LXa1gaPGnbRc4Ysxkquwo7
 7xZrLZzY9a9GCYH2HFSp/BDnE5+krbgg1TkJOikYuVo9zcf+NCN/xQZFvFNXDK8amVWp
 /bFYHWrKyp2YCvqEoZx+ltixyzXRndDCkHkHdsrrrCEgljLd7O0ws5rlcUB6T0jkW2No
 8qUmOY0ZarOim2yAw2Hsc5GP6vra48/r27TBA/x6svPuALnhyFuPtfUDuPbWtrAHOr6q
 ZVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779804933; x=1780409733;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pDEhYyW2dJMi85Y1zStgUw0dqF6oniUn/APg9Dgbdro=;
 b=Y4K+yA98g0nVidKfww9GRsWHZJ/M/5DQMPB07uIjqGCF1dMA1UQBTUaumlp7VJRivS
 2fbSfdlEhwroVR4kItydKNXhuQ3BPB4CNzk6D9Va+f8aiRw6/B5M1PmjXbMbsgYkoLB9
 3eAxpvmKVR8ty8bA/pUNgUpQK0GIVxSYE6RhfukOIaHXyVaMDSwphxAHQ3flXDlidNwV
 4A7NKK5ILa4E6rQo84IWLAjV57zKnEmu0khQYweYCzwl8DbDuIEbP/Um0Nr9ejNv5Xsq
 v5wPMq1j5Icqs1fPKv1aIcerpbdtXbHw2xXcChmfojJffXnlXvuLe1J6ZiKuK+D3C3rZ
 LKow==
X-Forwarded-Encrypted: i=1;
 AFNElJ/rxcPNuJK5XDNm5gVjcbpsk2TnzTmhSCRaoRZWiuPYAVhrDhC4+0iVzYxI8m47tc7pTWp6VEgYY1s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2aBaxbu7cbXp6+mqLz1wMila7xId7xFcO7r1Bzm3T/Tt/4VnB
 I8ShHMz8TqeJhWW4Wc8NvpdaKGFbFs/im3T+mpYuICwNO8fa8CDYph7eQE6xujaSANNfwFQiMaT
 Mgo0cnTpvoeM2506LOKS7cQxQK2ZcFpo=
X-Gm-Gg: Acq92OFVWERNVZCyOsUMNGgdmrLgyILvd944u3AeVzQtzjJrqonCgfOmzGXlpTWtla7
 Q3Wy2fp7NXl/IdBqLH/HuWrGYDvbMdNE93ByDLGUzf0+se5YOoGhVH7jlnju/RU4tgBXXUmg8Jy
 zhchilIg74+AoyC3P+q3Kd0PM5RPAeUYf1PkiKQdeWrBy3Oy0un1nWZpdl8+jb35YKGtLI5PqVJ
 KOKQ6pdZ+GnJXfUTHVCNP1plEep6YrvHyB811hznN6jrhQ0K5z/d8DF2aS7hfO4J/gapHM5tg9u
 ZtsHR5pJ0FF+/6mkiSAejiVy5JaDQMZspjV0/cLC1cCebXgdYLfDcD2E75exT0xiftwSbA==
X-Received: by 2002:a05:7022:626:b0:134:d037:aca3 with SMTP id
 a92af1059eb24-1365fa3ef8bmr2984957c88.3.1779804932490; Tue, 26 May 2026
 07:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260430010405.52591-1-kenner.linuxdev@gmail.com>
In-Reply-To: <20260430010405.52591-1-kenner.linuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 10:15:21 -0400
X-Gm-Features: AVHnY4J0ZB2mv1xChxAt83HPpsLFRk-FKZaQO5ikwPX2QY_kbwvz-npmP2bMC6U
Message-ID: <CADnq5_N+GpmKk+1oTLGhahwkCeT8F5Ru-yig7WJYK3XrANXhLA@mail.gmail.com>
Subject: Re: [PATCH] Fix kernel-doc for amdgpu_display_manager
To: Kenner de Azevedo dos Santos Miranda <kenner.linuxdev@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rodrigo Siqueira <siqueira@igalia.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Apr 30, 2026 at 3:49=E2=80=AFAM Kenner de Azevedo dos Santos Mirand=
a
<kenner.linuxdev@gmail.com> wrote:
>
> The struct boot_time_crc_info is not described in amdgpu_display_manager.
>
> Running the `make htmldocs` is showing the following warning :
>
> WARNING: ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:715 struct m=
ember 'boot_time_crc_info' not described in 'amdgpu_display_manager'
>
> i added the description that fix the warning and describe the struct.
>
> The warning is not showing anymore in make htmldocs after change.
>
> Signed-off-by: Kenner de Azevedo dos Santos Miranda <kenner.linuxdev@gmai=
l.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 74a8fe1a1999..201b4796b591 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -347,6 +347,7 @@ struct hpd_rx_irq_offload_work {
>   * @dmub_aux_transfer_done: struct completion used to indicate when DMUB
>   *                         transfers are done
>   * @delayed_hpd_wq: work queue used to delay DMUB HPD work
> + * @boot_time_crc_info: Stores CRC information collected during boot

This element has kerneldoc within the structure already:

    /**
         * @dm_boot_time_crc_info:
         *
         * Buffer info for the boot time crc.
         */
        struct dm_boot_time_crc_info boot_time_crc_info;

Alex


>   */
>  struct amdgpu_display_manager {
>
> --
> 2.43.0
>
