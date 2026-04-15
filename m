Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CB3F8A144
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F40E10E84C;
	Thu, 16 Apr 2026 08:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A+5cPSIo";
	dkim-atps=neutral
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC67D10E1A5
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 18:58:05 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-79a2ee65171so94357777b3.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776279484; cv=none;
 d=google.com; s=arc-20240605;
 b=E7zCjLoI8C8Lju0UY1bnWJF+f7cuqQ7rz2w1LuihJmzOaM5u1YvSLqinyp8wNPjzym
 yfpPGuMZU3vJGrMN434l7wPd7IfrE1s9XpoBGCbxeHX8FLalbVVYeb+CZUzriGuiDM69
 9en1GY3lRH2jyvMGyCvhdGGCs+we99x+Fqr1SMMZ6v9e03vTfsLiELOYziayJ64qQqqx
 ZlFfvPFb9CCyhgJFQfWxPFEWDXSrWUTS7J1fZQWZNH+Xmp1OvYTRuQWLsejTUns/Rw5j
 O2Pu6pIKnpJpsUop/+ng2Lij7mreILeeshOSJCawXkFLFrGVWOnZGujMUb0er8PO3Irx
 1adQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WJkNgpmjAJUMNFAZy462pqUkCnGxIcK8Oj4tXgu3x7I=;
 fh=PdDHGwoYwC6Re7ephasiT6DVzKCeTlIPiuKFCysHSM8=;
 b=H/XWqZrpoQfVdzF8uvDTK0zBhaTIEgzObzYzr/oBgQcZ0bhxdkWUPL1z7rbYXDK2bo
 2Tb9OVXTvumR3C4lA7xTkX0MY/5WXuoopKOJV4+WVdh93pfqpjbmszMoKzNcgjurF5PE
 CJwJJBIahn+UYnv3Xrrh4COos0jannHNUChPSrHVf9rJcsSGa3U7afIP/vm1M8qLFq3G
 cIRHxpxy/FAIrBHxTmZQxAm57Cv9KmZSnrhqZNEgM8OmeuTeJ72egHo6b+akXVH2oO8S
 WqbL9RgU35DX4rFNeKbqAyd9KtEZG6zAhAim9RyGLBi9/YOQ3keu8DLxFJZLtDHQw0Am
 ockw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776279484; x=1776884284; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WJkNgpmjAJUMNFAZy462pqUkCnGxIcK8Oj4tXgu3x7I=;
 b=A+5cPSIo5Pdinjpr55kZL6KifVycNhrUmZJ8T+i47vbrmm4vrUdSXDFFRyNN+YbKPL
 DpIPykiydDZujjEaadIi9PpIUQNc/U6jCOX+UKskiyiGKKUcnZ8BrOxRChwLAnLxwerI
 1q6qugCdkqFqUeBDp/vpFX7NVXBBTVFRo8NXUV9DecJV4FI6Jl4JYt7V5ftLUXEjyJqY
 EEYI224dIJP+W8M4h02O95OpdotrdA7sQNQnar4vM32i6PhZvPRyV9j6pgNdMZudtPpa
 j5uQuRqxWA0aD9JoeL2aBjONS0JBushm7oy50UWUH9OGwIumHqS9CVObNGrwAlhoIkuE
 mDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776279484; x=1776884284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WJkNgpmjAJUMNFAZy462pqUkCnGxIcK8Oj4tXgu3x7I=;
 b=LtjEsj4giDhbvkj8ZvQ5tiy6cLbnE71rZ7YDXg30qRXZUVvSy7JnyAg/rpXTZ8UO3k
 ZeVEHldyMcapoAQ7iV2x0D3PBmfMviCYDqJ3VMaO8ogu052L/9jEZOG2YqeBWbz6kXf+
 I6NzIjcbR3bGEJSh+KUU9mdOd4wvD5NUOf3as2NAUAYYuwvhWKcGfgsE1hNPJ0OUdJo8
 Q85O3bkANm6te1ggS29tFT88u1EtJq2ctzpkZ5tpRu2v+5dRco5Z10OF9u3ogSSNRz3V
 d3vAJH27Iv/8dyEWwvK6rJYGlrXhs2AD4oXJew8CzA4T4dkuGx1bDDcMuvozj8uyW5eN
 b6Dg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ZpGagYPUPNItFRNq2wNl+6Ki+6GbayxsERdhDCSsySeTzzHIiTklLdyLUGV8FQ3lY2xq5ffX1pBU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+/zqPlWI09kq1Lq3fzfGDuUVIu5vr1XYLmdBLD/kvpS4JahIY
 Dqc2WvJvuPbU2R50927H4xTUsyli5zVfoGrTLXmN8zUu5LQHS3sgnsqePRbGPALojGi4VVShVCJ
 tGHwIa/Hg6M3d+V9qVIz5TSc7D8JHrPQ=
X-Gm-Gg: AeBDieuCbRqGi37sJidwdmqtyAWnlnzM87wsbL9YAwIy38glsS4RLpyl0ZN+zsDvYlm
 sFkp9D0FkjSle1A2JFuhhLXitF6LAboKvHLG+Dq07PuaBVKVT9lLRVmGD9N55FFngoiJd0N4u6o
 yvI3XCdXldSdcP1BCS7cceeyrFqsWaBbt0NnTQZWubW4sH5b89HGJZjXyxgXwdPj7tmlpkQvtJo
 z83OikibXpeE43vwOE4saqxvSPM78XngK5AvBLp3xG4R1Vijrj/zB6VnrAE0mnH8cxjw3Elou6X
 EnMl2KceyaPe0/l3z5HO0I+fERF8EqGwJSqFdEHumYM+9UAlNUFAby/TDe0=
X-Received: by 2002:a53:c450:0:b0:650:3952:3d2a with SMTP id
 956f58d0204a3-65198a398cemr16592573d50.8.1776279484532; Wed, 15 Apr 2026
 11:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
In-Reply-To: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
From: Julian Orth <ju.orth@gmail.com>
Date: Wed, 15 Apr 2026 20:57:53 +0200
X-Gm-Features: AQROBzBSkv10qEpBfcDzfj3FA35dTp3Lau1TYsbQZLiEyzMQViUrWPUksWPwSQ4
Message-ID: <CAHijbEXcrhB=ipaa4-DPD8atQYCkokGfueLafwkeQpxCBkc0bw@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 0/2] Pass down hot-plug CONNECTOR ID to
 user-space
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, Daniel Stone <daniel.stone@collabora.com>,
 Ian Forbes <ian.forbes@broadcom.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 wayland-devel@lists.freedesktop.org, Marius Vlad <marius.vlad@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 16 Apr 2026 08:39:27 +0000
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

On Wed, Apr 15, 2026 at 8:19=E2=80=AFPM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> I will be taking over this series from Marius Vlad.
>
> This series addresses a shortcoming whereby a hot plug event is sent
> without it being passed the actual connector that caused it. This takes
> into consideration both the polling path and the HPD (Hot Plug Detect)
> path. It also adds support for the vkms driver (using ConfigFS) for
> propagating the connector ID when changing the connector's status.
>
> The motivation is that user-space applications such as Weston would
> previously receive non-connector-specific hotplug events, and then have
> to figure out themselves which connector needs to have a modeset
> executed on. This notably did not work when the hotplug events came in
> too fast, resulting in Weston missing an on-off-on transition of a
> connector, seeing that its state was unchanged from "on" so can't be the
> one that was hotplugged, and skipping reinitialising it as it looks
> through the other connectors that could've caused it.

Have you considered adding a u64 serial number as a DRM connector
property that is incremented every time the connector changes in some
way? Userspace could then check this serial number to see if the
connector has changed since the last time it queried the serial
number.

>
> The real world implication is that on setups with slightly sketchy HDMI
> connections, a brief flicker in the HPD signal could result in video
> output bidding farewell entirely until a manual proper re-plug was
> performed.
>
> By sending connector specific hotplug events, this ambiguity is
> resolved without any change to the user-space API.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
> Changes in v7 RESEND:
> - None, other than removing the leftover diffstat from the cover letter
> - Link to v7: https://lore.kernel.org/r/20260217-hot-plug-passup-v7-0-f82=
21b2aab51@collabora.com
>
> Changes in v7:
> - Drop the two vkms patches, as I don't want them to be blocked on
>   review. I still think they're correct, but they're not essential and
>   don't need to block this series.
> - Link to v6: https://lore.kernel.org/r/20260123-hot-plug-passup-v6-0-aaa=
f61d960bb@collabora.com
>
> Changes in v6:
> - Rewrote cover letter to explain the motivation for this series more
>   plainly
> - Rename "status_changed" to "pending_hp"
> - Set "pending_hp" in the existing path that would also affect
>   epoch_counter
> - No longer set the boolean in drm_helper_probe_single_connector_modes,
>   as it does not appear to be necessary
> - Reword commits to better justify the changes
> - Link to v5: https://lore.kernel.org/r/20251111162338.15141-1-marius.vla=
d@collabora.com/
>
> Changes in v5:
> - vkms: add support for sending the CONNECTOR ID when hot-plugging throug=
h
>   ConfigFS - as reported by Louis, vkms can now make use of ConfigFS to
>   simulate connector status.
> - vkms: add a small change to ignore previous/old drm connector status
>   when sending out hot-plug uevent.
> - Link to v4: https://lore.kernel.org/r/20251103174558.7709-1-marius.vlad=
@collabora.com/
>
> Changes in v4:
> - removed the "This patch" bit - Dmitry
> - added a short note when the flag is set and cleared - Dmitry
> - address double dead-locking detected - kbot: https://lore.kernel.org/dr=
i-devel/202509251410.fdfbcac3-lkp@intel.com/
> - virtual connectors do not seem have any kind of hotplug - added
>   polling in vkms - as noted by Ian
> - Link to v3: https://lore.kernel.org/r/20250923083636.4749-1-marius.vlad=
@collabora.com/
>
> Changes in v3:
> - Address comments from Dmitry:
>   - guard connector status write with mode_config.mutex
>   - avoid setting up the connector status and immediately unset it. Do th=
e
>     unset in drm_kms_helper_hotplug_event/drm_kms_helper_connector_hotplu=
g_event
> - Link to v2: https://lore.kernel.org/r/20250729165708.9947-1-marius.vlad=
@collabora.com/
>
> Changes in v2:
> - Address comments from Daniel:
>   - split patch into 2, one that introduces a bool to track connector
>     connection status change and a patch that uses that to be able to sen=
d
>     hot plug events with the proper CONNECTOR ID to udev and further pass
>     that down to user-space
>   - nuke out mutex when iterating connector list
>   - fix typo
> - Link to v1: https://lore.kernel.org/r/20250627131751.2004-1-marius.vlad=
@collabora.com/
>
> ---
> Marius Vlad (2):
>       drm: Introduce pending_hp to drm_connector
>       drm: Send per-connector hotplug events
>
>  drivers/gpu/drm/drm_connector.c    |  1 +
>  drivers/gpu/drm/drm_probe_helper.c | 39 ++++++++++++++++++++++++++++++++=
+-----
>  drivers/gpu/drm/drm_sysfs.c        |  2 ++
>  include/drm/drm_connector.h        |  3 +++
>  4 files changed, 40 insertions(+), 5 deletions(-)
> ---
> base-commit: 4c59525db84aca677fd9f052e662912ad9d88448
> change-id: 20260121-hot-plug-passup-f8ed03f7c202
>
> Best regards,
> --
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>
