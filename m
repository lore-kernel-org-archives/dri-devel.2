Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A0ECA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 02:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6ED710E500;
	Fri,  9 Oct 2026 02:59:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OudtSbER";
	dkim-atps=neutral
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7E1710E500
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 02:59:22 +0000 (UTC)
Received: by mail-vs1-f45.google.com with SMTP id
 ada2fe7eead31-7c4818e4165so1371234137.0
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 19:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791514761; x=1792119561; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hli6cl5EueM3Wmc/Onz03qSAHaGrKyC6bL0MwgrBWDM=;
 b=OudtSbERPuHUuHnHOsskog+2nmRHyTFKAJxIlm6UfGWq9beA5/daB0nBNPxFdemUFW
 hGczSEkgWLrH2qffGRi78GpWO9lug+VZzRaZFCyG/WMDzZ1144Ptn6ocN/dmW9ys2kXn
 dqdWoKe24b9cMXWBS5rVT55Mk1DNcEjCTJ7Gb9oflH7HafGNzyvmtQdH41vncS/oQIgn
 pbuK78XuHYUIqc7CRtFacOM38fbfysoGGKbCWQbjnQ6W46aMOuUIVX8dW9Nkiik9+g2l
 iK6N10J6diQl6b87d65nunbTIxVQKPfNf9ppLCmQg41CMOAEC+L6fDjl4DnQqPNkYUpE
 DHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791514761; x=1792119561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hli6cl5EueM3Wmc/Onz03qSAHaGrKyC6bL0MwgrBWDM=;
 b=y87BdPN1Mh53wwCZ+fsfH4GPfRAK9BxGM/ocypOVImpLXg4gu6xSnW/Nj3gceUAuFc
 4xK60Gfap5XFIpjSd+pI8ZZHXjt5lR3jXEC+C5fjOLWVSEKVmBAQs/YgU+VUjkeXyJFN
 gwzQ4S6ok9WomS3et6jUUyxgqBNjhUEawLzALpBgkONwJZnrYcRD4o31QHq3H4cyKsA7
 Ot4W2N0A1dsi3KwRm8KXNBvPFDCZuunz5PtrE3LsfaKej2MauY68Vutz7Jl2i/O7OzqU
 1qgeU4AENOzUvdvDFsRBWXlyiI1kQYrvCpjFuFme0/2MpjzwCT7tRkr9OrDkFzWj+SRV
 LgvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/uJwqILIqTVWMHHSuZPZeCqen6atV/cHw/ft/QKjnVxBfjGD6dtcwKW84IAjJ2WMs3Nb+MfjFvjU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIfwMpaY3rXsTbfxkttG8BaTEqWsOFKLjVvRWckNQ4UqRtlRgLp
 10bGNKxz6SKxMJtG8q422s5xN0u5H0VRA9HLZKu/oScRGZMn5HDrla2l
X-Gm-Gg: AYBFou2utMvpbH9AnfgBD9OjPjQMt2yx4gj3nc0/L6A1BvAWbImS7SkuUlfe6FlLvab
 BcEKZ8SuQin7we80AbQ0M9FxM8xb5+tf3fRK2ssRn70w9QyWOwTQXxVYVD5SdgqocXi5Bxr0dkq
 kTFWdVCE93MASdgAxRyUfv563Ah79zOfHgAvU1PByz2PfebMa+CmS9u6+LYIFY1AUVaAk88AQfL
 GoMP4U9iV7g984SHPQ+mRnd8HC/gNCiJCQkujqtTzwqeHbZWvfW9MT2cPGOrI9L63pxtGgiZBWl
 KDNDWbwO/1kyv5kYI8G3UPtnuxa/j3EhYX9ZXCtOK7/mEHoxNZ4+3HoWraZpzBVuyi0xi+aAcGi
 kofrvnztDHHBWpcFeLcLiyexdPpBZNAMwQ2RCRB4nHlhSoAnppJdHD5ez5FhMr+T/ivW9X/cd+p
 C7ID/AoPLgGAZijqjfTXBZFNO/Ini+Ocz/y0RbaPoTYzX1rw4jPa6Sa2w3SZP5rTI=
X-Received: by 2002:a05:6102:452:b0:7ba:7a64:5946 with SMTP id
 ada2fe7eead31-7cb3a1094c2mr118001137.35.1791514761520; 
 Thu, 08 Oct 2026 19:59:21 -0700 (PDT)
Received: from beelink.. ([187.13.210.57]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99003f8c0edsm758400241.11.2026.10.08.19.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 19:59:21 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/qxl: fix 32-bit overflow in the ALLOC_SURF size
 computation
Date: Thu,  8 Oct 2026 23:58:41 -0300
Message-ID: <20261009025857.3027341-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809002621.122832-1-qwe.aldo@gmail.com>
References: <20260809002621.122832-1-qwe.aldo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Dave, Gerd,

Friendly ping on this v2, sent August 8.  The original ALLOC_SURF
integer overflow allows a DRM_AUTH client to create a surface backed
by a one-page BO but described to the device as up to 4 GiB.

The v2 computes the size in u64 (addressing a Sashiko review note
about 32-bit wrap on the height+1 addition).

Let me know if it needs any changes.

Thanks,
Aldo
