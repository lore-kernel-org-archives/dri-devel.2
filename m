Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BFCC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 21:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DAF310E972;
	Mon, 17 Aug 2026 21:21:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kq92W1cG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hdM6gbPP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EA4A10E366
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:21:16 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HIRZ3Q1909629
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 afGPz63xhnfu36cg2pExGdt2huuSxFMXAiZn4lO4fFk=; b=kq92W1cGIWEdWLaf
 6Lr9bVT0Ad/PfCwJseAKtIg1aWldvuvXcWqUWD+3XZw3xQ/ibRLf3NVZWYZFWycW
 py/1jpBEHkvE5nik4Wv9NGPiC6DWYSrA9S0qDAXFSdC0apaeIvEnKAsDZLnEckLl
 p+FhB0s59Sx/1DKUv3Tqu+/Xhs7szAdW/GL2dPE4rw2EDPhOTM9Wt7C4hJQAdsux
 LSpBAux5EkMi26r6116C6U9lmfCGJ1npQcVO+fqfg1h7XFp46UME6+v+tM2D0X2f
 +kIEf7qDmIoOOVvAqyxxaVvQ1WYh1cFQJXs8QgDfo9ZgbvoSP3zDUIGT82qz9VYp
 7t1C3g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3wke3eea-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:21:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cfa4e4684bso113738785ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787001674; x=1787606474;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=afGPz63xhnfu36cg2pExGdt2huuSxFMXAiZn4lO4fFk=;
 b=hdM6gbPPaUlWyxZ7T0BkkOyjdByDsYOV4rl7BSkFDcgZMJLVlUhkYCZ4lTo935lN6f
 3EmT5SfKErGIAXmdVVMbqrHG1UUViOhKYPPrOHEQtQoAPzng5wkyM7U3uCDmDYZq2Fjp
 ND8QHIEEmGNsKHAAXbb4zQINImqTNSNvMSNOYpJyhG9t6sFjgLgpDGPpngi+jsvBEF4C
 Uzcehaa0l9zocOVax2ha71PBA7IRG/mN0CdmeC8Z1KeHl/hRCFxRYGzXigunmoHPTQKW
 1oSiYBQGLVwuExZtnRzVGBk9YEC9I1z7leMi7xUrqpmL8slgET1j33MGMxSzlTQ5Lrjy
 2qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787001674; x=1787606474;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=afGPz63xhnfu36cg2pExGdt2huuSxFMXAiZn4lO4fFk=;
 b=YawqYCw+5TIQss0tOLFg45YWIbRhFJnWn/Z+eSlZhPkr44wH049rbLWfDR4wpcvn2r
 97agdvV5pYx1TNW3Ia8uEE10RyILlpgcRigxukWWxwePtxXkeOZnuMFIMGEcsna97aJX
 PZwJAqN+Hjd8+JQCB2bKUZMcsrDUV7r/pW3yjW73B9U5FZZQOv3oGrOcNdpGJNBIN3Vl
 qyEcyeeC3OLnJ94Svo+nd1fCzMxqe8AW9qeCrMEQmn7IJKGDJyElC5SUCxGoNEKDH5vk
 TZsBR62AKxcMIDbsnSRdKQFXpzy0Lt58NVVJdb71r9je9AwMlMsfgjEHnUlati5zoYJu
 RRgA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHJzJOBekWlgOKSlp1zZ+INY5bcBuMVE/nDq8vLLWROMWK1ySibskg7AReBVWgf5hTTJKdF+aGPbQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxk1u0OGhlllwC1Mm7Qfg62ldRkRcO/NMxkMZbmszyDGFemJMkC
 hODciyhvwtaEyGFcCnef3/q0hWd9ibopjfggrfNjMeb8lgo+DB5gZ8mTWh2ukfRLx8zOjhBxIXZ
 SMAdBQ0W3H+o9h+Gq51iDDfHA1ncHA6s2nQrofmaD+mqGw+/F3RxpbdSUnJ2/6FQ/H7SXqlA=
X-Gm-Gg: AR+sD12RqvDJf28EMxF1hrW1APIj71e2g4Q7O+TAFzfSrMCrI4hkR6JfQRZk4C/g86h
 MGme4XnBnW4QgUs9Vq4kbFCsXnNuC2V94fApabd1RGS94qmwFOygkKfiYd+58zetkILTBPw2l/t
 EgnTzl8PUTBep6SUhIPya7aVSYR0BRkgu99S4sas+spijNw0unb7Hn4klbYsKLsUYt9cd7gW5WK
 M5Y6ATfroaFYLCuDdI7CpIPn5weAoeC2dKMphuzYgb0NpVQvWbGZKlTs+UPWOQb9NGJog9ratVk
 SLwJwK1FEyZX7E5oOzqGPtH9MsjhqVYl8pbEwbfMlkGDlEuQG7VQQ4CrFWMo4twfrpr85uAFafg
 d+55LO8E4Q3KNF+KmERxUunnVuQR3xDj9nUFEkHlkFjb8Zo294o2F0g==
X-Received: by 2002:a17:903:18b:b0:2cf:ccc2:6088 with SMTP id
 d9443c01a7336-2d3b080be2dmr285934525ad.4.1787001673963; 
 Mon, 17 Aug 2026 14:21:13 -0700 (PDT)
X-Received: by 2002:a17:903:18b:b0:2cf:ccc2:6088 with SMTP id
 d9443c01a7336-2d3b080be2dmr285933505ad.4.1787001673418; 
 Mon, 17 Aug 2026 14:21:13 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798cb9f5sm10948965eec.13.2026.08.17.14.21.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 14:21:12 -0700 (PDT)
Message-ID: <cd46dda6-3436-4b1a-986d-e925e6fd6bb8@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 15:21:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: check for NULL master in drm_getunique() and
 drm_getmagic()
To: moonafterrain@outlook.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <mwen@igalia.com>, Dave Airlie <airlied@redhat.com>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
References: <20260815-drm-accel-null-master-v1-1-93bdd3ba52f1@outlook.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260815-drm-accel-null-master-v1-1-93bdd3ba52f1@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE2MyBTYWx0ZWRfX4gZmlolj0k1d
 WanTyHjA2nJ9wdbItikiRhLZlcxaREvaudTwz2hgOjpx1VwEQ8RL25JoSJdTm4M7Trv+RlstvZI
 DwRa8ShAqI4tmUF7rU/d3iTMVkidTlk9uy8nr/dkLDeh0kkUKRoyHo2byzz3pNGdsJRghSoPtJF
 u3yxZi+DFPr263HGA9Du1bOcBQHau3ep52TijIy3tGO3XIhk8fwt3t71iBs4fC5uwiLlVHDSRRN
 YfJNR5+p5I2pyGoYNWVSgAZ4G02MdnHwQJvBrM2sc8Z6J8fhlegxlgFDM/pGnq07A6+pJ6C/e8P
 KwCl6GAlCqSMZ1Z/Gdn97vnHqTtPwgxjUS8gAzEFHtDxC80Ip85eL6NU8fvVhK/ACvJ82vglqe6
 Y5bkab/GOiE6ugeSSEqXvtGQru+dYIVkpkdxgEfGNbKfBYOX6DUZuGNVU6F6P5hEE5wHoyv2H/P
 M5xLMxuXE7qm323YdxQ==
X-Authority-Analysis: v=2.4 cv=QetWeMbv c=1 sm=1 tr=0 ts=6a837b4a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=UqCG9HQmAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=djIpYLbIsOyqsb7DCLUA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: JEpqtjgjomInyPMXH_iEDdsxCEf1-nKk
X-Proofpoint-GUID: JEpqtjgjomInyPMXH_iEDdsxCEf1-nKk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE2MyBTYWx0ZWRfX9y6bSOvzXYMs
 puespwQyjFuI0MvR8tkVEPButDDaQHleRjsWeKcWVeome0lJzcirFiFdS5KtpC2AmXHLZ0uGwc9
 7OngEOnSQuA1sF3oj0u7EYqIQYfUj3Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170163
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

On 8/15/2026 12:37 AM, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
> 
> drm_getunique() and drm_getmagic() dereference file_priv->master without
> checking it, and both ioctls are registered with flags of 0.
> drm_open_helper() only calls drm_master_open() for primary clients, so a
> drm_file opened on a non-primary minor keeps master == NULL. Render
> clients are already rejected by the DRM_RENDER_ALLOW test in
> drm_ioctl_permit(), so before commit 2c204f3d5321 ("accel: add dedicated
> minor for accelerator devices") every drm_file reaching these ioctls had
> a master.
> 
> DRM_MINOR_ACCEL is neither primary nor render: it gets no master in
> drm_open_helper() and is not covered by drm_is_render_client(). Issuing
> DRM_IOCTL_GET_UNIQUE or DRM_IOCTL_GET_MAGIC on /dev/accel/accel* leads
> to a NULL pointer dereference, in drm_getunique() with dev->master_mutex
> held. The compat entry point reaches drm_getunique() through
> drm_ioctl_kernel() with flags of 0 as well.
> 
> Return -EINVAL when master is NULL, matching drm_setmaster_ioctl().
> 
> Fixes: 2c204f3d5321 ("accel: add dedicated minor for accelerator devices")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
