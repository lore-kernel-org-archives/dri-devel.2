Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB66FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 09:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71DC710EA1C;
	Tue,  5 May 2026 09:50:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nw8kl+tQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UWKNJ4zs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B21DF10EA1C
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 09:50:57 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6456T0d61186892
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 09:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=tB0cuSXyWCVCcvCFqY9uCB
 KVk4Q/akucpHw1mtC7pLU=; b=Nw8kl+tQ7P5mhnuBW7lsALbsrmqw7Pz6NjQRtr
 yQ6PWTQtHiInrEehM2XKD60EeSTSK67mECBtV0gAOQsgu94UnQw/FN5fZ+XgSjI5
 DZnlRY4TQVpfas99sNRmAIiPy3VV7N8M8bqhopT8Attq5TfnZbZ8lhVXHswxMa0g
 kCZOt6t96kr3Iil7OYo6xypoFfZbb4IdJjPCdVTbPv/2YE1JbP2GmWD2mlngKrP5
 c4aC8d/hzfZLEiey11i5dM2VhDg3tPsTqOwj2B/VX0SX2jw17pDg8d8sy44ulhY/
 TqtCiOS7Vm714uIHzNVYIPlxYOuiFIBUzs7lDEprdAiYSqOg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvvgbqb8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 09:50:56 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-62f31e99ca2so3189541137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 02:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777974656; x=1778579456;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tB0cuSXyWCVCcvCFqY9uCBKVk4Q/akucpHw1mtC7pLU=;
 b=UWKNJ4zsuQHwlB/CdsrPt4kP3zeneo4oICGpw1oDCHsgx7ks6Z5TGSxAnvPt/KcZ6b
 m5lOTQWd8o9Md9RxaMHOiGmVxPaBCiycD7Kke7XJu0C3cLP1AuoJI5lnhLp7dP3qEUwM
 FxTVHxk7PmjY7ji19/7+6kVDXCZ9YKsvR65QlmqOkODLeVLr+8eTGjAkuFKyTlai68gz
 QFc/3UaAUFWfL7zCvxNky8PKaYodjionO6XG0+k7UHqI+6x21Iyj/MmmpyeQspr+hr3a
 +utpXNWBHwpCl7H/dpimBaQfrAE7RDQiay8aT+G8t4d2ncf7hEsNL9ETQ1+sAgUg0VHf
 ELJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777974656; x=1778579456;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tB0cuSXyWCVCcvCFqY9uCBKVk4Q/akucpHw1mtC7pLU=;
 b=J2qiFF519kP9nNvivEm8a64iOXRh9FBdwZBDV5psWkO/onO2lY5y5QgcV8FMz1iXV5
 BGQF+uvqTgwfZ16k/cgYoPCUBBnO1jgDkJFCVQI9r3ezFCNFI50usH8nYD+wkfXFBX4j
 58LZx4Z9i+/PyP7MbUngAQTPW9OFrOZ78i+74+OWGeoqC/nX1p3PdFU0GzkWWDTUnyXp
 MA6XYqCF6J0tn9zoXqlA/6n40iza7c+GGRDRZLOYnJzGaAbzaDUItewqsFzwNUEINGC/
 Lq9v9ejQrmdHhrHdzZ1h28rUtmoa2ZFpNOH+52Nutt9Pst6QLe6NtGk0KMJcH9GPBtyN
 0TnA==
X-Gm-Message-State: AOJu0YxmLAUewDoXVvx7GcFQdb5rvJz8RQdl9bKgLVxB/ufh66J+OgAX
 yB/DibePRje8nGEGCRiUWGuFrC6m1ETkI1rmDjZw0/gPFLYSwMzkg1Z4y1z5dNMC/h7cHzde+H2
 1HLl2sfZAXPuw00FgeQUGFzrSSHonhUJOU4SMqQhb0lEkNnFgOi9JRPCojcRUBgIeqE6FdpI=
X-Gm-Gg: AeBDieuGcBogeCF9mlUIk2aLSoX9vB4IZ1MkF+eKfSxVP70Fa8dRm90xOCQZhzyw63k
 59Bz4UZR+ifZa1CbO/PRMjM9VfJAyg1rY6gZgAiNH/sGCkYEnF8CzGGk3IqTx8+F5tQDvJRUxjy
 O2+esVAgxFoJM0UXk2F2sXK67tv/2SIwlujhav/SGIswxS1CLnooRo+d651ITuGIs5fYbfPsd3K
 J+ChwFQ6BVtxMo3QhWHAwUwBQ/7z7eI1RMVYpoH23sXIpAplxvHak4uEjEWJSJb/6bRBl6RmfD2
 mYlFa+L3+Zhp5sDPGvzn1G7ctjgvUrC3KtzToH8RQ+xOfgar6GI0Fw7/MgVc6cPPCz5nRRxz/ug
 r8dc2gS6HTkCaiWrffINVXzdsUdhrNgpHxxMT63JE/7N75b7/XqZ3EYJMZMoLE6xPmRaKRUcTz4
 +fjC5wZZV+/1HPgrhvkHKtdrTq7DYuT398gKROViRzXBvfLYOK52USI+ONvmErQQbzYojZhaMZ3
 pkKJYOChMfhhYV1eTvnmLKiKso=
X-Received: by 2002:a05:6102:8009:b0:62f:3326:fa4c with SMTP id
 ada2fe7eead31-62f55a5d6c0mr1245355137.21.1777974655722; 
 Tue, 05 May 2026 02:50:55 -0700 (PDT)
X-Received: by 2002:a05:6102:8009:b0:62f:3326:fa4c with SMTP id
 ada2fe7eead31-62f55a5d6c0mr1245348137.21.1777974655324; 
 Tue, 05 May 2026 02:50:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bc1b97a11easm219088766b.44.2026.05.05.02.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 02:50:54 -0700 (PDT)
Message-ID: <b8b4fc94-6aae-4558-a4bb-13c26cae186f@oss.qualcomm.com>
Date: Tue, 5 May 2026 11:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Daniel Dadap <ddadap@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-fbdev@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>
Subject: Plan to fix nvidia_wmi_ec backlight issues, help wanted
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YhXZRrrLOKgZgssUk1zocXjyxoDOcz3o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA5MiBTYWx0ZWRfXxL5U3VNYARGf
 PSn0y2hqWT3pRagFC8gXCpO6Dn5JqOgHQMAb3ePIU0cSAj2rlsDRLk+3o/QNbFkzNNZK2dWdKyT
 CTWmkEk32gK4PvDXjE6o21DS7Dx/39X13OwV7GqFUPIvZKklYYdTUBlf6nLanpGTTVF/5khrqjh
 NB/7wFKWrpSIlcDiDoP16oWd+3juKhytPTY6ghL7jB0X+ZN+c6BpMIi0wFOjTa69bEQTObph4jr
 jaJH6VDEbtH7NYbTbbmdRoQ6MShdCAq6t4tMDB1mzPxt0jmccYOjJ6GW4NYNgfguOztscqG1HN0
 hZRldbTYgalePpZbWdiE/APyj7aS+q6dw8+DP7o4ZDyTEUcSyWiWIQ2tCknoR7xPHlGvqn5pS1D
 s3mMAqXBIihXgRzCIudipZYIquMWlQMufZL4Z3jnQn+YuxDF4P+rpuR/5m214lN5/LuUL3Gh22q
 WEt0cP9YksmEQCOnmqQ==
X-Authority-Analysis: v=2.4 cv=K+AS2SWI c=1 sm=1 tr=0 ts=69f9bd80 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=GHR8O2WEAAAA:20 a=e5mUnYsNAAAA:8 a=iox4zFpeAAAA:8 a=FQzLeyTS56HO1ZxThNwA:9
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: YhXZRrrLOKgZgssUk1zocXjyxoDOcz3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050092
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

