Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3CCC4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E04F410E397;
	Tue, 21 Jul 2026 17:50:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ASvgd7Fe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BLoROdSk";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8294610E3B8
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:50:54 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LHROjq2446214
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o+kSKircGJJssMtsVtZrC2MOvMJ8MTShbijhdvfgBLY=; b=ASvgd7FeqlBW0yAA
 w5kn1Z1jWwgvgNyq6jWMhP9a8mvNFp5GEM1r4g+Ze53L3H9GUTVBsAPJQXs059iF
 ft9cgJcC21niwfU1hSdl+E8YBAz4nroAhoZ/QD1O4U/D4EaDo3Picfd7x7G6AtIv
 sAot6yE5KGXZPpCUY4HNkBpioRds4dmxy6Tij9nv7irhZt/+bHnUkSggnc0SqXHt
 MUt/j+remEMv3ETO0XNMbnZXNitCpnR2geaW+MZVUw92S9gsjW7l+AOQh1hHRc4s
 kcN0CH4UebvpmAhDQH4iidDLIs3Zjp9ByDkmUKSpbOEpEzi0LcEK8t+Suv9Iyeai
 DR4ceg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6d039c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:50:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c2af04aeeso36031541cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 10:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784656252; x=1785261052;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o+kSKircGJJssMtsVtZrC2MOvMJ8MTShbijhdvfgBLY=;
 b=BLoROdSk/5ve2fT7aGT4+X3tUWiEbidvE38XpMtOUyHbXMLKC8LIkK71iGdbm0HdWC
 q8BgStmCFNyr1WPJktTHZdYR7DHJ75b6H4uSM1u1B8l231F+CidCGtamdCOYxCYTw7LE
 D6A0/yRTq4rBX8FAznWW4lazug7GBc+1YQgVQ6baKG/WBFFmYDqP62nu0/scXzFwDG35
 yoDd5bhyHrL8n8yG66I6YNC0lnrVuNZzRWf9byg+u41Jih99/NWsyUZhnVIkaHiI4X6x
 rMvHScwEZZtVmokf8dA7XDmAzFGRIULCewTfE5PluY7anT27XM+tDV/u69nNB7r9NwpS
 vKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784656252; x=1785261052;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o+kSKircGJJssMtsVtZrC2MOvMJ8MTShbijhdvfgBLY=;
 b=p/QniJHmh4ZkWg84hoFcdbAkX+UDZk6fs4MCH21lCztH7aQ4HJg+vzuLKj7wtDXFWs
 RA+0cpEx8gKD6ICS3/En9CgB0+5Cf1kSQytKSEbF8gqXSSgeY5+JhwfGV3t1MBjdwD9/
 2DIG7atLAbnjuJ9Jl6COX/PtP2m/6iabHZqDKKq3hwqOCjxUZl4ukwDdSrmWYQWWiI9o
 2Uy8JUz8T7d+OCGeQNUytcsg5oXv6p9k75buLAqX6fb6TDkMycp22SF0veCEVgchVT8H
 cQy2PMKt45yLULtQbErQdL4Gzsly95ZYGxajI3rt/q+bDAD/NGKruICpDnHN2rJugTQn
 LRIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5/LhgW3Ug20WUoCUYB0Aga1Qw9CeeWjfGiSGSaZHK4fdN78ClGWj75RGBkgwlUIXox24zlpTBW9A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYdJAzcF7g2gjf5eKySnxg6hziWtRBAVgCU97VE1Zhl3IUSTLo
 AMBnkZTPtpqv6+v4iUsRO0BbjbdMd2dCkiqvcDPToYUV1JcmAnVIgZpqHnYWpC8rBE1v1is90ZQ
 qU3653Xwu8Ui8JdSyfmvgws8UQEEA8xYxmYZRK+k4kkUKRBh5WbtN/dU9hYqEwRCkJ/G9J/g=
X-Gm-Gg: AfdE7cl4D5qUmAW3abNSjhp7LH7rSpq3wbd3GkFD4GfWwsmDzdEaks1oGAQZG2xLv2n
 Cif3QlljuNh7fkoI/x9+qULEE+9ypnz0mHgckyiaEWKmA79706A7G6p0TXWWfpO12wGQu8FqhlQ
 L+fWyXGifEV3w9T2NzvmI7c8rglU+dtHU0/ZfT2jT86P0B3bKcYQ/1G9jF6IxTSa0Dq/YoOU6n4
 gEF7zHdxubGLdn2VsrRvlsjxVP76KTgm1qgUSzrSdrPJn5yLaTs8Ae02rAEM5GczULyM8FPQa7U
 VtN0zhn65aO2pcvT7cBHQGG9P1btJhTC8eETwObVc/WBMOOWTyBv4GdkuakQRmu+scYHYEX98NO
 ZIE69Oo56efNPQJhMpJwO/WrLIDegULqI+UHJPsBC5eJv/vXD9D0sbEV3b6LwlLPKzZLCevKmaA
 YlnnrWidI6NN4z/Z5z10g2bSax8YZfHwo7lkZNqoIApgVIcXe+lRO9Y/DdO29QNjvt3Wg=
X-Received: by 2002:a05:622a:8a:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-527a817b5dfmr7329881cf.22.1784656251976; 
 Tue, 21 Jul 2026 10:50:51 -0700 (PDT)
X-Received: by 2002:a05:622a:8a:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-527a817b5dfmr7329611cf.22.1784656251422; 
 Tue, 21 Jul 2026 10:50:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32ac700asm4389266b.15.2026.07.21.10.50.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 10:50:50 -0700 (PDT)
Message-ID: <3566a1c5-c273-4928-9a07-56064c0936f0@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 19:50:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] Add support for a DRM backlight capability
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Mario Limonciello <superm1@kernel.org>
References: <20260624165751.2014759-1-mario.limonciello@amd.com>
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <20260624165751.2014759-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vYFXLDhl34_yntbNx-9eqDrlR9NyMkUA
X-Proofpoint-ORIG-GUID: vYFXLDhl34_yntbNx-9eqDrlR9NyMkUA
X-Authority-Analysis: v=2.4 cv=XaG5Co55 c=1 sm=1 tr=0 ts=6a5fb17c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=n9G7CmtyAAAA:8
 a=3fyaaF4VAAAA:8 a=_nvYoSmVAAAA:20 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8
 a=CnpRRkJoLPI7oaxqQMkA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=QLbfUV9tqJ42EE2IvXC8:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE4NyBTYWx0ZWRfX9FiKCPiH+n0I
 qVkv7QZMEKBccjRxEfJ6XptuKBJId70j2G2N+08wF7oO+2ORdIPJETqkOjUIa73TRQaSIc2TEJp
 j0HwFmakDpID2howiPgvhV2q3E+vE3ukOGjQWrNWUT8+py59hhlXwbrNkJciIiwzMuI3u01sSva
 FxbhF8eQKz6Rq/CXRFrB0KdorrI+z5U0KPTTHdH2+sZx4BAqX7ZTwA9CVkgFtfQXSQAVnL+9H5M
 CRw25Gj18uVKJAw0zrNFb+Rpo/HHdgjPFzAlv9vIhwqD3H5rV4MUa1dg+pfIMSgzqWU7xSGLuXt
 cgmUTwcJQ+oFylwOTH7yW5ooF9WftkHwzRz0g/LxAalmhsMIvu22AcizNn/aG+RgG/uklc9a+DK
 FHsAv7dW4XtIo2h4HfCPTpe0I3crEgy1uiBpWhvXzJZumcISYP9JBAKXAI+lW3SQsH7hefY614x
 GyBj79vOHjQv3T+zT6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE4NyBTYWx0ZWRfX3cF3PXWvxRbr
 3wChkyoqBCqQOlOedoGdZqeK0FgQ6M/L8BzNlT6e0ovfmfbr0FydexgZCeMdx/RY/mO05SowW++
 51RToWc+WEEeXlkMGutyQbnZ3uubDaA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210187
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

Hi Mario,

On 24-Jun-26 18:57, Mario Limonciello wrote:
> From: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> At Display Next Hackfest 2026 we reviewed progress moving brightness
> control into the DRM connector properties.
> 
> There is a range LUMINANCE property that will default to 0->0.
> Once a driver attaches a backlight it will be updated to 1->max.
> If the panel supports the minimum backlight turning off the display
> the range can later be updated to 0->max instead of 1->max.
> 
> The legacy sysfs interface is synchronized with the DRM connector.
> When a compositor using this feature is loaded, sysfs writes are disabled
> to prevent legacy tools from going out of sync with the compositor.
> 
> This has an implementation initially for amdgpu, i915, and Xe with eDP
> connectors.  It can be extended to other connectors like DP for displays
> that can be controlled via DDC as well later.

First of all thank you very much for working on this.

I'm a bit late to the party, since I only became aware of this
patch-set recently through:
https://blog.sebastianwick.net/posts/display-next-hackfest-2026/

Overall this looks pretty good to me.

My main remark is related to non acpi_backlight=native backlight
control.

When I first started working on implementing backlight control
as a DRM connector property I never got further than a whole
bunch of prep working making sure that all backlight drivers
(and all drm/kms driver backlight code) were using / honoring
acpi_video_get_backlight_type() resp. its special
acpi_video_backlight_use_native() variant.

This prep work was meant to allow the drm connector prop code
to deal with the case where e.g. the backlight code from
drivers/acpi/acpi_video.c (acpi_backlight=video) should be used as
is the case on many older laptops.

The prep work basically made sure that all backlight hw/fw
interface selection handling (on x86) goes through
drivers/acpi/video_detect.c . To have a single source of
truth of which backlight control method should be used.

Looking at e.g. "[PATCH v6 07/10] drm/amd/display: use drm
backlight" then this is partly honored since 
amdgpu_dm_register_backlight_device() starts with:

        if (!acpi_video_backlight_use_native()) {
                drm_info(drm, "Skipping amdgpu DM backlight registration\n");
                /* Try registering an ACPI video backlight device instead. */
                acpi_video_register_backlight();
                return;
        }

and the added drm_backlight_link() call happens later and thus
gets skipped if the acpi_video_backlight_use_native() check fails,
but any non native backlight devices never get linked.

What IMHO needs to happen (perhaps in a follow-up series) is:

If the acpi_video_backlight_use_native() call returns false then
replace the acpi_video_register_backlight() call with a new:

drm_backlight_handle_non_native_bl(internal_panel_drm_connector, pci_dev);

function which does the following:

1. Call acpi_video_get_backlight_type() and cache the type it returns
and on acpi_backlight_none bail from the function.

2. Add a new acpi_video_register_single_backlight(), which takes
a pci_dev pointer as argument and then only registers the acpi_video
backlight matching that PCI device, see the parent handling in
acpi_video_dev_register_backlight().

This new function then returns the registered backlight on success
or NULL (or maybe an ERR_PTR()?).

3. If the type is acpi_backlight_video call
acpi_video_register_single_backlight() and link the returned
backlight instead of the native one.

4. For other types register a backlight notifier which listens for
new backlight drivers to show up and then checks those against
the cached type. And on a successful match, link the new
backlight device to the connector.

This is for drivers/platform/x86 backlight drivers, like
dell-laptop on old Dell Latitudes which will typically not
be in the initramfs, while the GPU driver will be in
the initramfs.

5. After registering the notifier, check if a backlight device
of the expected type has not already been registered beforehand
and if yes, link it and remove the notifier.

Stating the obvious: 5. needs to be done last to avoid a race
between checking for the backlight device already being there
and a new backlight getting registered.

I specifically have retained a bunch of old laptops which use
the acpi_backlight_vendor and acpi_backlight_native methods to
test this. I even have one with 2 GPUs which IIRC both
work with acpi_backlight=video and I can switch which one
drivers the panel in the BIOS.

Regards,

Hans






> 
> The following compositors have implemented matching support:
>  * Kwin: https://invent.kde.org/plasma/kwin/-/merge_requests/9298
>  * Mutter: https://gitlab.gnome.org/swick/mutter/-/commits/wip/kms-luminance-prop
>  * Wlroots: https://gitlab.freedesktop.org/wlroots/wlroots/-/merge_requests/5384
> 
> ---
> v5->v6:
>  * Rebase on drm-next
>  * Drop patch 7/11 (Move backlight tracing out of the dc lock)
> 
> Mario Limonciello (AMD) (10):
>   Revert "backlight: Remove notifier"
>   backlight: add kernel-internal backlight API
>   drm: link connectors to backlight devices
>   DRM: Add support for client indicating support for luminance
>   drm/amd/display: Pass up errors reading actual brightness
>   drm/amd/display: Allow backlight registration to fail
>   drm/amd/display: use drm backlight
>   drm/amd/display: Drop brightness caching in amdgpu_dm
>   drm/bridge: auto-link panel backlight in bridge connector
>   drm/i915/display: use drm backlight
> 
>  drivers/gpu/drm/Kconfig                       |   1 +
>  drivers/gpu/drm/Makefile                      |   1 +
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 111 ++---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  13 -
>  drivers/gpu/drm/bridge/panel.c                |  15 +
>  .../gpu/drm/display/drm_bridge_connector.c    |  15 +-
>  drivers/gpu/drm/drm_atomic_helper.c           |   7 +
>  drivers/gpu/drm/drm_atomic_uapi.c             |  59 ++-
>  drivers/gpu/drm/drm_backlight.c               | 445 ++++++++++++++++++
>  drivers/gpu/drm/drm_connector.c               |  63 +++
>  drivers/gpu/drm/drm_drv.c                     |   8 +
>  drivers/gpu/drm/drm_file.c                    |   5 +
>  drivers/gpu/drm/drm_ioctl.c                   |  15 +
>  drivers/gpu/drm/drm_mode_config.c             |   7 +
>  drivers/gpu/drm/drm_mode_object.c             |  66 ++-
>  drivers/gpu/drm/drm_property.c                |   6 +
>  drivers/gpu/drm/drm_sysfs.c                   |  28 +-
>  .../gpu/drm/i915/display/intel_backlight.c    |   4 +
>  drivers/gpu/drm/i915/display/intel_dp.c       |   8 +
>  drivers/video/backlight/backlight.c           |  97 ++++
>  include/drm/drm_backlight.h                   |  51 ++
>  include/drm/drm_bridge.h                      |   1 +
>  include/drm/drm_connector.h                   |   8 +
>  include/drm/drm_file.h                        |   8 +
>  include/drm/drm_mode_config.h                 |   5 +
>  include/linux/backlight.h                     |  63 +++
>  include/uapi/drm/drm.h                        |  22 +
>  27 files changed, 1046 insertions(+), 86 deletions(-)
>  create mode 100644 drivers/gpu/drm/drm_backlight.c
>  create mode 100644 include/drm/drm_backlight.h
> 
> 
> base-commit: 0e8233409d4f6def051dd42a432c6815bb780d78

