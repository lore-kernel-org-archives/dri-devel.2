Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5DF606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nzjcr1Jv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LKOHgg+K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4276E10E90B;
	Wed, 25 Nov 2026 15:06:46 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6415210FD07
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:06:34 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6APEM5RU047628
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F8Fmq8LWA4bhtyNOLWl2S9LNOHs1l6eqA9F+R8NUX+A=; b=Nzjcr1JvAe8O3y2M
 nRk02gsmzckXBcRxfri+XHtkdUIEszeIzfFyQQgR/BocgtLFL+n+eCBxHRzQ6Yfq
 qFzg8RINXEMwOvBf0/oUkncHMiBTksHiHC9BqK7fPOJQt+fer1msKMHomuVFo02M
 HWlOZeJFWN/NORls8UyWol1U9y/9hHAW4fZgccoU7/Sbqi2bbTFG+4vjo+f4z3En
 x0PMMHwz77Py3aOkFJX8N0yFo4LC9oqXKJIiDzifeX/5Vv+KdoJ8lIpcubq7K9D4
 SMLEBhZdEr0PMudXVoqY9KyOzziQXsPFG/RnejlYfRIxAoE94rHnRlkzkztqvvLf
 0Vovvw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5mc2befk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:06:32 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cdd9fa2a558so4660458a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 07:06:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795619191; cv=none;
 d=google.com; s=arc-20260327;
 b=iixIfazYGG+rvHSEkmlqAfBsU0ajKPj1bIf5a/3RqZR0cfg2qce0YB8nQlyRE2SlWW
 PMwlSSCNumjIrSCb4gty1kAsYD27TbD/pSR0uYQv0L76AD5GQjeUReU+GO0MEWZU84ld
 1KemKWRe2J/uVWAx/F6u31T6R/6jICAugv/wos1C3EqCFLUS1HzH3LGcQFtPE/8+y2ip
 o3/uIhE02QC3k6j80nJ7h4n0EJXTdquThOHwnu8fd3evZld4X0yPFmlhXt15DtcrhEWx
 xFd6hurjSvl7BI9rRlLT5gOEpERo//XdSfZFKza2y4dGdgX1ylLILZm7BPrm1bYoycrj
 oBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=F8Fmq8LWA4bhtyNOLWl2S9LNOHs1l6eqA9F+R8NUX+A=;
 fh=9lN5qptZ9grx5KrBHNKTc37dwKMltp/UWWo1cZ8FvGY=;
 b=BjBKCKgflDEbAcQOgqKdfyTJhiTZJgKpnIz8qxzroDmc5WLprvYArNv6rn1+/tTNar
 x+f9ZKWD9TOR65XlEwJ5OpISeC+q0ejs+BiC+tWcYEIBpse3v2xmhBxDIx3a3mxj3eIC
 sxIwr2g6vAwVkmE38I/eaD07RZ7pm9uh8B2gnkoreGfcKMfueKfNjZqn4CWgCqE9nL/n
 kY6NyHy6HwaNYWIxVgmvmnHsZR1U1V1LaYqhBzeJ3KRrlVvq7n64yBe0yY4NnaUJOK/U
 A83XJizTG5wUTibYuxmfDhKF0G77vk4UvY2fGLCiZ5NAiXj245MLOEDYAE4OFVk+W0tK
 wvFg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795619191; x=1796223991;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F8Fmq8LWA4bhtyNOLWl2S9LNOHs1l6eqA9F+R8NUX+A=;
 b=LKOHgg+KdWCctoOv0j2Eq1G6cUhv5JGMYcQ1UH6aVjx/k0ozjJZQE064GenQG0q6Yh
 swDnmgn87wVsjAJE+AeSIpVJ/HOL3lCIoyhs/qRbxmRzCjX3FkVz0/aO9H5rkgscbb/X
 reccwXdkwe9ivAFCzgmm6VPY+SbLGdKGLdA1E1/L01mWzc/+ziKTIro6w43K0WboEfk1
 gIqWDOkQ2W3U48SS27IThP2WCf6lNNdua9URd4IUzPBLpSWDl+UmFeOT4hFeD3mFog75
 Ug52AVKZgSQ/+xR4HUKbiGHVuwtP/UHlExT1XT7UsTrwgCy+4vsdi8y1ARNCu0KciJjR
 F1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795619191; x=1796223991;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F8Fmq8LWA4bhtyNOLWl2S9LNOHs1l6eqA9F+R8NUX+A=;
 b=sHUnANIEilirCUdkuKVPclIDmNmIQshC1+sd05LKx/FhISzpLMBGihOkpGyVN+kyNA
 bv89QEvHThoqh1Laxn7inM0akzfTBKizgCkaxaLxnJxKgGH/f2OW8RM58CbsHjJlXSTE
 V3/wzavfJBpZ2RS2PaCNlFXB4aZ4+UG3Gj2KljhW6GYd6KymunGbl7U28Xpr1Nb8hi1s
 qxsG4R+mArPWh3+eI9Z3VoKRjyjtZzGTRWnqa1CXqm9FC9V4m+OqVrjhd3yDedThCjJL
 Q/nKxcNSrpYLx8yVOHoeldLzTjcwk9gisR0lhiIeHSZsd/JriNOEBkhofSeGLNymZHJc
 40Eg==
X-Forwarded-Encrypted: i=1;
 AL+hErGrM7qNBnmsD5T4oSxTWvWwO096PhH+0cZq/Tim0hFcAJFn1XMsW/QnrxX97+KHzU49waB4RVEmCXI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+US+SJIRK+PDghRJndSEr0297HvB6NO3+FsL5cf3LlbnCgioi7
 XwouzmlQUARoKv1DzMEUj5a00L6hLLWy0St2nLJym2GpVRMKS46FkuP16EiCP2PHBpka79tu0xK
 ZlQxteZBPiJoGO3CgcX3GugXA8AJy9Z13w5RiJfk56nd3/YShjn+Ub9a4eWNj/yvkBLLJBk5JWg
 M6X+dLjSblxeDP+00VlLMhpTPkh0CqFV7cqM/wkVr0poSrCA==
X-Gm-Gg: AZFdTZfLQ4q8rLjWyu5dLLy+zprNYYG/dOEEgQ5AyR6Au7beacgobtezFEyxs9cAbLG
 47V44XDE0PfRXMaPNX0IdvP0mhQY1w28oRVSFCxITD/nzV/N/mOklYusHldgGe8TFw0bb2pPDCd
 jDLZOLND0ULufIDnwSks4wyBcvUWtsVkAb/GGF/J4oQhD5g0YlXvZvs/5gBA==
X-Received: by 2002:a05:6300:8095:b0:3dd:a196:69e4 with SMTP id
 adf61e73a8af0-4014d14d2d3mr16907597637.63.1795619191485; 
 Wed, 25 Nov 2026 07:06:31 -0800 (PST)
X-Received: by 2002:a05:6300:8095:b0:3dd:a196:69e4 with SMTP id
 adf61e73a8af0-4014d14d2d3mr16907537637.63.1795619190966; Wed, 25 Nov 2026
 07:06:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117173738.1073856-1-Frank.Li@oss.nxp.com>
In-Reply-To: <20261117173738.1073856-1-Frank.Li@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 16:06:19 +0100
X-Gm-Features: Aa3M54qxdRmYOsZoBrTl4IfLXTc7pY51UNG7OdOGBQV2sjgdmvbFz8dtj3UY-KM
Message-ID: <CAPx+jO8oqBcGCSUReJJVMjsnQg+xCv_X8LhFVaGk0NDuOqmEiw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM: runtime: fix stub pm_runtime_get_if_active()
 for !CONFIG_PM
To: Frank.Li@oss.nxp.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 Alex Elder <elder@kernel.org>, Guan-Yu Lin <guanyulin@google.com>,
 Mathias Nyman <mathias.nyman@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>,
 Maciej Falkowski <maciej.falkowski@linux.intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Will Deacon <will@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Bingbu Cao <bingbu.cao@intel.com>,
 "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev,
 Frank Li <Frank.Li@nxp.com>, Alex Elder <elder@riscstar.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Karol Wachowski <karol.wachowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=aPJlOr9m c=1 sm=1 tr=0 ts=6b06f979 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=8AirrxEcAAAA:8 a=ee_2aqc6AAAA:8 a=VwQbUJbxAAAA:8
 a=ag1SF4gXAAAA:8 a=QyXUC8HyAAAA:8 a=GFqr32JmAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=tA7aZXjiAAAA:8 a=EUspDBNiAAAA:8 a=_jlGtV7tAAAA:8
 a=1XWaLZrsAAAA:8 a=e5mUnYsNAAAA:8 a=JfrnYn6hAAAA:8 a=f3U7k-wd2kzf4Rf19YkA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=ST-jHhOKWsTCqRlWije3:22
 a=VOpmJXOdbJOWo2YY3GeN:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=f02Ha7HRcztGgdyUxOxW:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=kIIFJ0VLUOy1gFZzwZHL:22 a=nlm17XC03S6CtCLSeiRr:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: Xa5U7ERg1M4vbep-gs2Gc9x5fIUvhlxv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MCBTYWx0ZWRfX1WNckv5waaqC
 r4Goh2Fmt9HXeAu2xF+AVnlUxMLW/hZUq7ABHfKFzhmkfpnlCgt6HYU+8HfJ+R3t9lFSjCEr85B
 EBrHlEiZvYUpo+tuVxBJTiM44IqbZwnDuYbWVdFV8uwi8n5Hcq552NIp/XlQYv6FZc6HujTEjyp
 zg1obicLEcxlkR3deozlcfAIxw4P9LZC9l5OU0SE5NNAeEF6dXxeytqelUlLP6G08lpShAmvHcC
 KUrXYH++yp4mSztuailNGZRAJ88Nyg0Mp2WEhKKuF9jKA/JQQXLS5/RfPWsFHX8gjyL+mVcQJQg
 pA3BR9MSAu5T7G8Q6luNrtXix4cAMHqvAMbFeogjQXNrinGXSGZuAhxjwX+qPEMDoBVF9Stmi4K
 hB8QIzLpIFNJjID1b+uv5xCXHdtFfBAF1VWUfYtnpu+9omMwyFy4gF8ytVd6p/+ZncLP4ju8+k9
 VZiygVgbBtZ9jGt8Lqg==
X-Proofpoint-ORIG-GUID: Xa5U7ERg1M4vbep-gs2Gc9x5fIUvhlxv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MCBTYWx0ZWRfX9OFfHJrjgE6W
 rDeOUFVvrChbahG6rXsaFGnGsZKfbkxz3DLI+g954q4ujoetotlCmyK6OiXc8Er7m7MXvzHytm0
 wZICyscj7awDU08VQCcTnklof2udM7k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250060
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 6:37=E2=80=AFPM <Frank.Li@oss.nxp.com> wrote:
>
> From: Frank Li <Frank.Li@nxp.com>
>
> When CONFIG_PM is not enabled, should be treated as if runtime PM were
> enabled for the device and the runtime status is active.
>
> It's a subtle distinction but the previous behavior returned -EINVAL, whi=
ch
> means "runtime PM is disabled for the device"
>
> __pm_runtime_resume() returns 1 (called by pm_runtime_get()).
> pm_runtime_get_if_active() is the try-and-get version of pm_runtime_get()=
.
> stub pm_runtime_active() also returns true. So pm_runtime_get_if_active()
> should return the same value as the stub pm_runtime_get(), which is 1.
>
> Analysis of all callers and their behavior with old (-EINVAL) vs new (1):
>
> Pattern A: if (!pm_runtime_get_if_active(dev)) -- no impact
>   Both -EINVAL and 1 are non-zero, so !ret is false in both cases.
>   Callers: drivers/accel/ethosu/ethosu_perfmon.c,
>            drivers/gpu/drm/msm/adreno/a6xx_gmu.c,
>            drivers/gpu/drm/msm/msm_perfcntr.c,
>            drivers/gpu/drm/v3d/v3d_mmu.c,
>            drivers/gpu/drm/v3d/v3d_perfmon.c (x4),
>            drivers/media/i2c/gc08a3.c gc05a2.c og0ve1b.c ov6211.c,
>            drivers/media/i2c/ccs/ccs-core.c s5kjn1.c lm3560.c (x2),
>            drivers/media/i2c/s5k3m5.c thp7312.c imx283.c ov64a40.c,
>            drivers/media/pci/intel/ipu6/ipu6-buttress.c,
>            sound/hda/core/device.c
>
> Pattern B: if (!ret) after get -- no impact
>   Both -EINVAL and 1 are non-zero, !ret is false in both cases.
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c (comment says "allow access"
>     in kernels without CONFIG_PM), drivers/pci/pci.c
>
> Pattern C: ret > 0 / ret <=3D 0 / ret !=3D 1 checks -- FIXED
>   drivers/usb/core/offload.c: checks (!=3D 1), old -EINVAL caused
>     -EBUSY even with !CONFIG_PM. Fixed: now returns 1, proceeds.
>   drivers/accel/ivpu/ivpu_job.c: drm_WARN_ON(<=3D 0), old -EINVAL
>     spuriously triggered WARN. Fixed: 1 > 0, no warn.
>   drivers/gpu/drm/i915/intel_runtime_pm.c: checks (<=3D 0), old
>     -EINVAL triggered error path. Fixed: 1 > 0, correct path.
>   drivers/accel/ivpu/ivpu_sysfs.c: (> 0), old skipped freq read.
>     Fixed: proceeds correctly without CONFIG_PM.
>   drivers/gpu/drm/xe/xe_pm.c: wraps (> 0), all xe callers
>     (xe_bo.c, xe_shrinker.c, xe_vsec.c, xe_ggtt.c, xe_guc_ct.c,
>     xe_pxp.c) now correctly treat !CONFIG_PM as active.
>   drivers/net/ipa/ipa_smp2p.c: power_on =3D (> 0), now correctly true.
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c: (> 0), now correctly
>     executes stall register update.
>   drivers/staging/media/ipu7/ipu7-buttress.c: active (<=3D 0) early
>     return now skipped, correctly proceeds.
>
> Pattern D: explicit -EINVAL check
>   drivers/hwmon/prom21-xhci.c: checks (> 0) then (=3D=3D -EINVAL).
>     Old: took -EINVAL fallback. New: takes (> 0) fast path.
>     Both succeed when CONFIG_PM is disabled; functionally equivalent.
>   drivers/hwmon/eic7700-pvt.c: call is guarded by IS_ENABLED(CONFIG_PM),
>     stub is never reached. No impact.
>
> Fixes: c0ef3df8dbaef ("PM: runtime: Simplify pm_runtime_get_if_active() u=
sage")
> Fixes: bd3d245b0fef5 ("usb: core: use dedicated spinlock for offload stat=
e")
> Fixes: 7806bad76ac39 ("accel/ivpu: Prevent runtime suspend during context=
 abort work")
> Fixes: 1524c28b99527 ("accel/ivpu: Show NPU frequency in sysfs")
> Fixes: 46edb0a3eb16c ("drm/xe: Fix xe_pm_runtime_get_if_active return")
> Fixes: a71aeff3dd0a7 ("net: ipa: kill IPA clock reference count")
> Fixes: 70892277ca2db ("iommu/arm-smmu-qcom: Make set_stall work when the =
device is on")
> Fixes: 9ad65684b9285 ("media: staging/ipu7: Ignore interrupts when device=
 is suspended")
> Acked-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Ulf Hansson <ulfh@kernel.org

Kind regards
Uffe

> ---
> Change in v3
> - fix drm/xe fixes tag hash (sashiko)
> - drop i915 fix tag because guard by CONFIG_PM (sashiko)
> - fix net ipa fixes tag hash (sashiko)
> - Add c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_active() usa=
ge" (sashiko)
>
> Change in v2
> - add fixes tag for patten C.
> - add Alex Elder ack tags
> - change subject to fix stub pm_runtime_get_if_active()
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> Cc: Karol Wachowski <karol.wachowski@linux.intel.com>
> Cc: Oded Gabbay <ogabbay@kernel.org>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Alex Elder <elder@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: "Joerg Roedel" <joro@8bytes.org>
> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Guan-Yu Lin <guanyulin@google.com>
> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux.dev
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-staging@lists.linux.dev
> Cc: netdev@vger.kernel.org
> Cc: imx@lists.linux.dev
> ---
>  include/linux/pm_runtime.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 64921b10ac74f..de9e7518ecef2 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -280,7 +280,7 @@ static inline int pm_runtime_get_if_in_use(struct dev=
ice *dev)
>  }
>  static inline int pm_runtime_get_if_active(struct device *dev)
>  {
> -       return -EINVAL;
> +       return 1;
>  }
>  static inline int __pm_runtime_set_status(struct device *dev,
>                                             unsigned int status) { return=
 0; }
> --
> 2.43.0
