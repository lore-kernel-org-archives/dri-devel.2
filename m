Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFAECD342F
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 09:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68A1010EA2B;
	Tue,  5 May 2026 09:53:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b0qZ3ilX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LZgIWlIw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E2110EA2B
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 09:52:59 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64595bES4028256
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 09:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=4iPppo2ySxxvyZPF9M4kzF
 a3748LIB8tWCe9fhXp9sE=; b=b0qZ3ilXaGU5mRLT6Ywli/N8RTUNj0yFQSRw/S
 B/dhR18t8n6BLOI3y4bzXQJBI70T0Op0Ga4OMPHJXTVkYvgAp+cKHMOOvJfxMLfO
 SwVViBlA9dP4c17Y/Uc2mQIPc1Q+0AAFsiUkPnh3h1Q9wFJfaZDGRlvD99egwPqL
 X0glxxScCvQghPnL8fzoE4R4UDF5vQJQtdlxF5M2Ee4+HfN2uRjaa5+zR7N96lO7
 LTL6oYVEtAxHg/LN4zJE/03d7PUEBGiUsaYNg66LWKttT0n4huuHucasS2SpN5fe
 7J/FZRfIFaotQbSDWBa570Rz/P16SZje/6vFARLKXHBUYQ5g==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dydm6r5nt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 09:52:58 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-57539ff73cbso3478194e0c.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 02:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777974777; x=1778579577;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4iPppo2ySxxvyZPF9M4kzFa3748LIB8tWCe9fhXp9sE=;
 b=LZgIWlIwMVbI3noWQXT6CKp/jy1Sqkq1UDljeCN2jJ7y93oJIvdj92CubxivE/Kmp2
 8P/nr/i40u/K0DWad1XGjJLeBTyojjNvQpklgOZ+T04HWq7mZgvh2GRrZK1Q4uPVdop7
 EB/7SNwdQWjo6HnPf5kECU7KUUoI+UYteKX/mT3kowrFcg9pkB15x/mn6y179xOZ9pO5
 NCJU0pST5C9IWn09AZ6DFZYgrR1aQLEGfhuXNktDRZlOmv8smfGuQYa0XUOA8syqyZqJ
 1nc7+4Vu0ulLa9PB4gdaIqKQxo1y1Si71bhTPp8xXdLIQz+8bEvSuDXvCD/91tMOVEkh
 I9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777974777; x=1778579577;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4iPppo2ySxxvyZPF9M4kzFa3748LIB8tWCe9fhXp9sE=;
 b=YGQtfMs85F//ycazPumPXy69fIUh5W4wAkgS0nLhIQIx2oYy9Q87i+XJUNxCHu//qR
 RgvMGt8NApUeRdjdu3TCUuhW4RtKG+mVDXoQ7lq9NzABLUcdE7Bb5r4x7Soqftsr5Kuo
 fzFXOPoM1Y5GCn5wBl1uT3kLmLu7lWyGgfDA2wQs4i7qxewd5rwj5M7xiei1WjEfQqm8
 KWfHRPLgK1g9tmxaVwdrbZLDtreldsmmZjowleZQ4tBJWFz5du8SWB+dQPwHXNgLshjF
 z//orUo9wPMpOZZwiu1dFi/z0+AwLQ65uwWht4BLSzYKlRwatAEnZ/JXcmXnPF55TH5G
 aSww==
X-Gm-Message-State: AOJu0Yw65rNK15SX7F6EzLVpBNOZtXd8UWpz+e3FSiQSAuzd2ngCPBZd
 QHj0211Z6Uc3bYc8iBg1eOm/JcQ0gYkz9fIvXyc15qBy/sMeHvky3lRxsdHCtqF+n0XTzIUrcTg
 TxwAnWjRm4kgLxnEVuS4ZWFRxP54RY8f6HrhetvsukRKfW487g3mAqMWFPT01zNwKLHZfcPs=
X-Gm-Gg: AeBDiesjclUZQhtjNt733CK6NNTdmp/hE8qDdzPB7ezfhOeJcRYdSM91EduLpB6jlS5
 1CJXpSvAvoraW9M2/kLQup/gBt2VCTakNrKYSXNwjeq1cFSELO9L2m0cmiWjWfsf2+mJFKy57xI
 5VzdU1xRvpDcoqBrLeB6mZ2AB3vCQE/0OpJJCNRtwNW5Yi5N0Dw1MlCupSCzn3b3ihQr/yGeZWd
 11TBvaza1KHU3b/qF7gXMIAE2KkohO6hgIiIjjszdDOHKM/NHWSkLNtgXJRgAjOrFY6HV9yCiS4
 MAEllWNbm0CvYFFZNDSAXp/VK4e+0yJley3cg+VAJk+rwfsapqQcY2/jpXaQIIKbzTI2FoPaWz6
 apbk5Ji2CBykI03mqghS6ek9B1fB1qlBRho3Dla/bVQ8XBiLRiWSbUbqE5vHCChW4iZlxk9S3vS
 JMq0UZVqM3ybvrvxhH8mPwwADuY+vshXLv3qip26N/+MYvUM4QQx7dCEP8cXtoCbzQVzabS782G
 vd7LVjuiRhpk6EE0D4+witehlg=
X-Received: by 2002:a05:6122:1d4c:b0:56c:f222:7d7e with SMTP id
 71dfb90a1353d-57544892cc5mr1074434e0c.10.1777974777374; 
 Tue, 05 May 2026 02:52:57 -0700 (PDT)
X-Received: by 2002:a05:6122:1d4c:b0:56c:f222:7d7e with SMTP id
 71dfb90a1353d-57544892cc5mr1074429e0c.10.1777974776959; 
 Tue, 05 May 2026 02:52:56 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bbe6d97db6dsm474656466b.51.2026.05.05.02.52.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 02:52:55 -0700 (PDT)
Message-ID: <f10c039b-e9ef-4aae-8291-8f1e71074586@oss.qualcomm.com>
Date: Tue, 5 May 2026 11:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Plan to fix nvidia_wmi_ec backlight issues, help wanted
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Daniel Dadap <ddadap@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-fbdev@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA5MiBTYWx0ZWRfX6pFg6tUryklU
 imQHo+npuJmGeG9UJJMZ4He7EtrxCof61sXlnJv36ggo1DuU5x8YDDLZ0OXjmtK5VrNbYcTfG9C
 m6fzj4OhXeKGwn1GVJKeYcEp4SRDnM+r7LzxfpxFpds4EMx/IxR/l1OUO23hA8c2/U3FFLDW9Cr
 tHq89zCVHGEC6zaejd7SVCyciA1JQa8W48HJzICnFWLdwz5eKyeINMz0Md2jSe3t5fIzb2qNrE5
 sNIn/p6vQDBvzuE7ivjmYlEmfgs2MENPie0RmeVIxCuP0iV3ukc6j49Adz4YE7pDDrpveICAVsm
 yDOhNl8qdVMyXKI+1sJqiitFqRV44qzIIAN46dTbj5sTQrFZu2/2D9UqPvmkVZ/WSRlKyucjVBp
 aw0/v0IsxdS+Qy6JjFgXDpNSJ3mc2meVzA8Uyml0GQ53oixS3nK90/6GJpmgAGg2J5eiGNB6t14
 fR3CCh9AXcmfq+y2jjg==
X-Authority-Analysis: v=2.4 cv=K4AS2SWI c=1 sm=1 tr=0 ts=69f9bdfa cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=GHR8O2WEAAAA:20 a=e5mUnYsNAAAA:8 a=iox4zFpeAAAA:8 a=FQzLeyTS56HO1ZxThNwA:9
 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: TBIToUVZZIPFVVFcOQYFXzAhaAkWuCTl
X-Proofpoint-ORIG-GUID: TBIToUVZZIPFVVFcOQYFXzAhaAkWuCTl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050092
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

<resend adding pdx86 list, sorry>

Hi All,

A while ago Nvidia introduced a new Nvidia specific firmware method
for controlling the backlight on laptops with runtime switchable
Nvidia hybrid graphics.

This is supported through the nvidia-wmi-ec-backlight driver, but has
never worked 100%.

The new WMI firmware interface has a method to ask the firmware if
the backlight is controlled though the EC and this the new WMI interface
should be used; or if it is directly controlled by the GPU and the GPU
driver's native backlight support should be used.

There are several bugs in the implementation of this on various laptops:

1. The method to get the backlight control source sometimes does not
report the correct value.

2. On some laptop models which method (native-gpu vs nvidia-wmi) works
changes at runtime, e.g. when plugging in a charger.

Known affected laptop models/bug reports about this:
- Acer Predator PH315-55: needs acpi_backlight=native
- Dell G15 5515 with RTX 3050: *needs* acpi_backlight=native
- Dell G15 5515 with RTX 3060: *breaks* with acpi_backlight=native
- Lenovo Legion Slim 7 2021
- https://bugzilla.kernel.org/show_bug.cgi?id=217026
- https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/work_items/784
- https://gitlab.freedesktop.org/drm/amd/-/issues/4512
- https://bugzilla.suse.com/show_bug.cgi?id=1217750

It turns out that under Windows both a WMI backlight driver and a GPU
native backlight driver get installed and Windows simply always calls
both when the backlight changes working around these kind of firmware
bugs.

When this first came up, about 2 years ago, I came up with the below
plan to fix this. Nvidia was supposed to work in implementing this,
but so far an implementation of this plan has not happened.

Note I do not have time to work on this myself. I'm posting this here
in the hope that either Nvidia will pick this up after all; or that
someone else can make this happen.

I'm more then happy to help answering any questions which may come up
while implementing this; and to review the resulting patches.


The plan
========

1. Modify the core backlight code to allow registering a backlight-device
for in kernel use only, disabling the registering of a class device under
/sys/class/backlight .

2. Add a new backlight-aggregate.c backlight driver, which exports a
devm_backlight_aggregate_register_or_add() function. Drivers can call
this passing in an existing backlight-device (with its sysfs interface
disabled). This either creates a singleton /sys/class/backlight/aggregate
device, or adds the passed in backlight to the existing singleton instance
if it already exists.

This new driver always exposes a range of 0-255 to userspace. This acts
as a proxie for any backlight-devices registered to be part of
the aggregate, forwarding any brightness set calls to all backlights,
scaled to their actual range. For reads this will report the last set
brightness value (starting with the value of the first registered
backlight-device).

3. Add a new nvidia_wmi_ec_and_native type to drivers/acpi/video_detect.c
for both DMI quirks and commandline handling.

4. Modify acpi_video_backlight_use_native() to also return true if
the __acpi_video_get_backlight_type() call there returns the new
acpi_backlight_nvidia_wmi_ec_and_native.

5. Add a new devm_backlight_device_register_native() helper which
calls __acpi_video_get_backlight_type(true, NULL) and if that returns
the new nvidia_wmi_ec_and_native type then registers the passed in
backlight with the flag to not register a sysfs class interface and
then on success calls the new devm_backlight_aggregate_register_or_add()
with the just registered backlight device; and if the returned type
instead is acpi_backlight_native register the passed in backlight
normally through devm_backlight_device_register()

5. Modify the i915 and amdgpu drivers to use the new
devm_backlight_device_register_native() helper. Since this new helper
checks the backlight-type itself, drop acpi_video_backlight_use_native()
checks *if* the registration is the only thing guarded by that check.

6. drivers/platform/x86/nvidia-wmi-ec-backlight.c to not return
early from probe when acpi_video_get_backlight_type() returns
the new nvidia_wmi_ec_and_native type and for that type make it
registers its backlight with the flag to not register a sysfs class
interface and then on success calls the new
devm_backlight_aggregate_register_or_add().

Regards,

Hans

