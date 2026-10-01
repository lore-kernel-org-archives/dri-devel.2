Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDB1CA5FC4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F3C10E2EC;
	Thu,  1 Oct 2026 01:11:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VDZARZnS";
	dkim-atps=neutral
Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com
 [74.125.230.234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4168810E2EC
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 01:11:43 +0000 (UTC)
Received: by mail-qk2-f42.google.com with SMTP id
 af79cd13be357-93bef17c191so505739285a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790817102; cv=none;
 d=google.com; s=arc-20260327;
 b=g2lwasVlbi2ULXus4dr5B/a4SEFkc/514oDlcLeKZ6BNwdRgEF7TlhVIdu4eLsedQw
 ow0niLdps5l+xmovyHeAeI2eGzSbFGmM5l9xSNmCfpQm2NhJ1DGno8UBpzhg4OaupWYl
 GVtRSjMWWGvXTjUoR27/dzwUqcDP+8PeMqLzsikQ2nMp7jHNj35OVWhIaE9TugAcYWVA
 owhaA3vny7GAXr363cXFwGsmd0ZxvshO1xFv3ZAuPcoVRHsu/8q8Rd9wKvQgvI22Df+9
 PU0E5F3wba+JYMugwsgKlgmXpZWWszWykoZD6X3wopSe3s6vTBRoBayy00koBj7CyNDi
 1/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=j2lUHQEvxQq6oSekhyIH0GMwW8MfXgmP2gtiBIUWvJU=;
 fh=8F9HNHqchQMvgzLuIZzf74ZZNRkTs1q2x7A1+wC43bA=;
 b=JCaNF2g2hPNd8GPKbTx+FDr26WhtF1q/oKBKdrDIlexNLDubPYRr1AFYxrXNZKk4CL
 4N+Rs6bPuF8XqUiRH3BD64mnqJZcan4nGuc3Eu6jc254bXws1ssIQss+VFlKXATrA6vJ
 VwNQpOq87Rn3ei2TH0X5tMbX1GbKgux1LHT8ayWE2s3xwIqelGd6HGamWqbqNOIWgRSJ
 kVPsYB+N5EUCFl3elTZBEO4TOXyUQKX7WUf8gnmqhudDaxhC68NWnJ2GX6dIOI78PGg6
 S0LGTWHOj0PgVYd5Pp8Z7fitUdCJ3/2c8WilVOsohsjeGX2PuZuZ3XrFZX6DjLUTJv6w
 PR9A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790817102; x=1791421902; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j2lUHQEvxQq6oSekhyIH0GMwW8MfXgmP2gtiBIUWvJU=;
 b=VDZARZnSHQMTs8f74zIx8UWXh8AsW7fEFf2fCvtEV7wUr4FiM2vD8C+hKBw22tMzg5
 oLu7pnjthD7zNPIct6f0H+9S1jsLwII9kWPDF3oK732+N4Ru139PJMICRBfIcuootBjQ
 OmLCFJXjG4WBkQEBmG8G3s+oueeuhGhSImq4dbOU7GdMm46auKJfL/22jkziDmKFZuxn
 XrrVjqZK2Y5dFy1FrTbIdUGV8TinS3i5IlFMDDbJMndcxlx9JE2RnlunI9g8I4f28t7K
 DmQUO/JoFu19gdB+MBgWIcb5RIDQYOWsmYR6Gibu5tJTdW/rMye4rkKCQ0u68xEZQRlN
 o5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790817102; x=1791421902;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j2lUHQEvxQq6oSekhyIH0GMwW8MfXgmP2gtiBIUWvJU=;
 b=YSF4VKftRn/JDfZJlbX+jMDvljUyxENKLOt1KrEeooVHhSpKgFi67hyexDMrz3eWie
 YJWJKXZNySP5+98zFvOvDchLmTgC+YE0Ff9rsxfjCgnNZK/likSXXr/C8n9ZGhx258g3
 9mEbuiLnLQkbSs1R+ZxliLYxyAv4y1h6EwAOgH6j/rreEjMtmIWnJEBrwqHxF6Kfhd5U
 CIuKpw0c8682mKAa3T6rmyMCQ4mUwwA8fwYXxsu2n+J1iK0g2n6dTdQ314TUMsq9ufP/
 HJ5soiXNk8b8VTBXpwOq6cI0hS7x2sZvTLxbh4Jy98tlqeECIVsDTejqJvta5vFj4QE6
 oxKA==
X-Gm-Message-State: AFuF++n3/h8yi4sSadSTcb4J22f1hK6xOLIKI4QeNLsMWPGaZeUAn2Ba
 1AhhMs+kJvt5b+7N5ll/gddcTn3I62mPMUi58MvnSiXLgzi2ckMcwBjpGOYHrzQGZ+NxjMdbEu9
 9ihwXaL1GOjSqrTfZhLwr+wTb+wcvY+s=
X-Gm-Gg: AYBFou2OWd952r4aNwoFyKlJuK0K34iYbsp3FQWSodJHzz+TNMfkF8tYUQX8DlIZupd
 IryAyp62xb/8BT3JCTHaHTUs+ttffsIxYDfqaJBTnuFthMMSuTL4XLRrTNidOvUaypAD2ruLZvU
 1gSpeyg3zVti+uUnhMe8L9kVONrko8qWlxtyD8KAtt5QmR/jpUxiyy60a76SinmqVdTfMfNMdZ7
 +9H9MFMM5htov5qheOW2tiNxytTqFKAclfXAiQ2YX+0seaOqbyc0qNUvpDBartyb6gQmLw4Clkz
 7xkXyM7q2kMnFmLpCR52edFwE+w+Pm6ltfP5Iix4ZQb0FF81FXq0mgL/WzB5L+oMcXH73lrP62f
 RTg3T7vY8iDoHRSEaD3WWCvai2OYl25TZjiueoPzi
X-Received: by 2002:a05:620a:410f:b0:93a:48a:167 with SMTP id
 af79cd13be357-93ca973260fmr620112285a.39.1790817101420; Wed, 30 Sep 2026
 18:11:41 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 1 Oct 2026 11:11:30 +1000
X-Gm-Features: AclHuK_SqvGAge7WzM1f7vJNZGejVdSGb3A7pHevUcMQPH0euaaJnITn3-QqX3Q
Message-ID: <CAPM=9tzd3LteJG-Au=na-_X5Rff4tacFZ3X_cp5g0bCcQkV_jA@mail.gmail.com>
Subject: [git pull] vgaarb rework topic branch
To: Dave Airlie <airlied@gmail.com>, Alex Williamson <alex@shazbot.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
 Bjorn Helgaas <bhelgaas@google.com>
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

Hi me,

I will merge this to drm-next today, the topic branch remains
available for vfio if they want to base things on it.

Dave.

topic/pci-vgaarb-rework-2026-10-01:
pci/vgaarb rework for drm/vfio

This reworks the vgaarb API to be a bit more sane.
The following changes since commit 93f51579e7df248780214094418f205253383cc5:

  Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/kernel.git
tags/topic/pci-vgaarb-rework-2026-10-01

for you to fetch changes up to 93d41424caf7569ab50092a922477e2a881232b4:

  PCI/VGA: pass a data pointer to be used in the decode callback (v2)
(2026-09-30 17:21:59 +1000)

----------------------------------------------------------------
pci/vgaarb rework for drm/vfio

This reworks the vgaarb API to be a bit more sane.

----------------------------------------------------------------
Dave Airlie (1):
      PCI/VGA: pass a data pointer to be used in the decode callback (v2)

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  9 ++++-----
 drivers/gpu/drm/i915/display/intel_vga.c   |  7 ++++---
 drivers/gpu/drm/loongson/lsdc_drv.c        |  4 ++--
 drivers/gpu/drm/nouveau/nouveau_vga.c      |  6 +++---
 drivers/gpu/drm/radeon/radeon_device.c     |  9 ++++-----
 drivers/pci/vgaarb.c                       | 13 +++++++++----
 drivers/vfio/pci/vfio_pci_core.c           |  9 +++++----
 include/linux/vgaarb.h                     |  8 +++++---
 8 files changed, 36 insertions(+), 29 deletions(-)
