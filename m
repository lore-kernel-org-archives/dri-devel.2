Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD144C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 23:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06D1010E141;
	Tue,  8 Sep 2026 23:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZsD2llIY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y9hVBuld";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE47E10E141
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 23:00:56 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688Mglr8482942
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 23:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ihPYqdrPGXWVbmFBzBhN4BZ9
 OU7yUZppyNtH0Hlwg+k=; b=ZsD2llIYuQgi0sjhlL9VY5XcKD05Cms4T5S7p32D
 FuZh1o86KtTVKXDXy29YuSCtOVg0XQsdeqjUwl3YZHk4UMDPzCMcpWvef5UXgQgx
 dXjRk+QsQ1nBTKve3ACVZmUnOcdjZVSfdH6j0S1/EwF6ZTjj404E27H/9vvG43LE
 f8FN4kFyozAONXPxHSpm3CDpypkUp9G3QV8VdiFYAP968Y5m2uUNAFPSJ4oi6PbF
 SRDP/uXQEdFmFRIpfHKG4hbLplTqPsThnhw1njeIGCiwKPGdyzsjdWjiatKKadND
 guHN7bu/fd1w2rPO2rZyD+U6kW5VQMOJM6fYSFXJPrK8EQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqf1h3hc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 23:00:55 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-78faf713ab2so39736137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 16:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788908454; x=1789513254;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ihPYqdrPGXWVbmFBzBhN4BZ9OU7yUZppyNtH0Hlwg+k=;
 b=Y9hVBuld7W0/s/EGlQ/gYDwvSHUKypARHrK5ZMfU0+LHFZskFSGllbx4KbZxPvTOp/
 JlU5+3NoI4RlRWyH55M2OFn57Iap9fwi32qf9reJunWRUGU0tehmxLNCDb/6Pmw7WW0D
 pNqBNlxsoiSgzewLO5QDsB+0cBVOLSevTLNIO0OrfOfZ8MoZYRr1pO9fjNLP2IEs9qS/
 KNUQmuTl5FtZriZZBr0WE7Pb7kD+GaWruEdImYWWEm9W1TVIvgoBNMIrbxjQs7iRxvXG
 JAs6SUltWd0TM/nvl6swWMz82u2aLtK16ocddb8gbeVUaZN0k+A/McGUZ3ECToHskONv
 ET0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788908454; x=1789513254;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ihPYqdrPGXWVbmFBzBhN4BZ9OU7yUZppyNtH0Hlwg+k=;
 b=nN6cKvh7fVkYKVtVIO6zbRMdtaGadfJ/iCVk4f9LvhWHAhDOtKtTF0WgFCENvC0zlg
 r91HmrhQrTIhuMHRmBNIPoiV2jwPxXIoWT6Su6RGl2Ch5nyVb6AdEhStkRKTVBk0ao3+
 xkjPXDZjZ/VJyZF6GeqLKgjHdMtkLm1DtDzkeFRgWbR5vVz4rWnADrZPPBN6Oi6n7xv8
 kOr7ytxDB6c50J3KGa8jGgSwI2bCKMILOSNyQEp7XSn4zjU6bLyNsZP6vL2EjuNE4+zh
 f3DZ/UNZXUUQFfh/Di6vUMENKXbMqi6Nvn6mpN39dxuGWhP7yUcSoR2pa1K2erDxhW50
 v3Kg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZGn7upqsiiyo7OuLTDr7kBFyIsER7iX3PfB3qhMuvIKLgFcPkLVSFqdrQHBsYH9oiUJ0DzCVtUCM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kFHVbwLdUegcEfgRkfbUsoSKh+Kzxrjce/UeNJk4sV+C0+zYWE
 KvSy8542RsJ5JEJhBUW9ZGwdI4CEHfu1iZQ9hisOMQ6o6BiDBihlMVFGx5BfQEf5AYcFLfslhzf
 R/GoTRkHh/MDNh12SLrS/eCovsxdqqPg8PLnfyA5fqqzGNIxlw4CKjtOyFLTPlDttipxMG9o=
X-Gm-Gg: AYBFou1fec71CHe2SRHv2ALyrmoagr+eGctGxyxWJi/EI48EBLUB0+3AbzVTG3Kv5Ww
 L7kw9NmbTu+80eblpzt7fA2GV+iZ+CZ39sj/KZwNPuT7VYgJ+x3FMDF4uGHxX8qWBxoGuH8J79B
 pSeaRK+PUHnUxHSZnO3OG7Tb7gZPviu1Mg8vTMIzknHwcPY23bzNlCFDXqREzle8ei2rEV8Tt7e
 A/fiZXc2leFpIHcvHmEvOCI2j5EH78voFBOUbVRHguU9wzU22gi1s9fPNqMHecOGWHfAyOxkYuc
 eQTPwogdMV349E7ApQh+KXAdGyN08SeEj8kc2iOstCzOq9onPwH1nlSdt1lC/3d35xrUOKgwXwZ
 TxXBSi3tdP+a3XUdD5WwjKAbeDbdl0x/GyGzkr+MHeMP6EAG0V++8jgR8WXzekCtQxt2tRpoI+2
 MBfNB1RauQQqar
X-Received: by 2002:a05:6102:5e90:b0:780:d949:663f with SMTP id
 ada2fe7eead31-78f73e27b69mr1092799137.4.1788908454332; 
 Tue, 08 Sep 2026 16:00:54 -0700 (PDT)
X-Received: by 2002:a05:6102:5e90:b0:780:d949:663f with SMTP id
 ada2fe7eead31-78f73e27b69mr1092766137.4.1788908453845; 
 Tue, 08 Sep 2026 16:00:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b6166fbe6fsm3317542e87.41.2026.09.08.16.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 16:00:52 -0700 (PDT)
Date: Wed, 9 Sep 2026 02:00:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: rob.clark@oss.qualcomm.com,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 09/15] accel/qda: Add DMA-backed GEM objects and
 memory manager integration
Message-ID: <iviywddjpdvfx6qcsj7ki2ketbljkzqvkcmwfeop3ur5z2x3dl@fqicfxi5shh7>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
 <7030a8f8-f320-4b09-b2de-2c8e897409f8@amd.com>
 <CACSVV00MubttbkVJgMommPMorf67yqn7D1kfwpxVUZ0t-6au8Q@mail.gmail.com>
 <2febead3-0f0c-4e0d-b11a-8c61ec027f44@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2febead3-0f0c-4e0d-b11a-8c61ec027f44@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDI1MCBTYWx0ZWRfX4IS3G3mqG/CG
 Tex8a86uShX9Gv6pnUVT27jWfj9yEdVZokplp6Dj56WLNqkXr7GJb2XUW3u7OkjV/MhZLWBr8Dn
 oDidUnqK0ZJHFlgY1o29Wbd7zUHOi/KrfFwmapVbk4JIF1FaL19xzGNTlxpDjVlPaygE3xx9O/Y
 ZgZrdKvf9L5i2l4c4ZIEpSD35mNXCmyM130giHEGd13c23e2zg0ihQuUeuO0SnpztgJyTR52kcA
 xOGYOV6d5rHZ3GmJRJkGQIgk/2I/mj4MqsaHxGQJ4diAe7WcEkpYD0INtbFvkkNiOJwfYTq3/U4
 r4x+DIxqlJKezMGatMPTFZXBAWTOE65DguK6bbbTprw4GidRZZP6NcDRMS7g05Ke6/5TRbCEIUy
 a6nZ3QmvRXQ7KUfGMxgosYu6m2CLrrt7zyUYzAArbcJlOilP7J07ozkY5X8R2crfHap67sV+etV
 f/M19b1mKhwxL/LhHBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDI1MCBTYWx0ZWRfX61Wb5gE27qP+
 cfeErBQc1/uFf4NPEkAklUd47m5n+sUPOnUC0xsSwINF81m1f8D3rooiISVuiBcamyZe560a15R
 wZ0mtlxPg16gMoH6d3wu5L1YX6LZHUs=
X-Proofpoint-GUID: lJ8vS4IyfX3YnC0dBLTxsGkXHCotI4GD
X-Authority-Analysis: v=2.4 cv=JY2Ma0KV c=1 sm=1 tr=0 ts=6aa093a7 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=sLzL-2GVjjNmCx-rav0A:9
 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: lJ8vS4IyfX3YnC0dBLTxsGkXHCotI4GD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080250
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

On Wed, Aug 26, 2026 at 07:15:07PM +0530, Ekansh Gupta wrote:
> On 24-08-2026 20:37, Rob Clark wrote:
> >>> qda_memory_dma.c / qda_memory_dma.h
> >>>   DMA coherent allocation backend. qda_dma_alloc() calls
> >>>   dma_alloc_coherent() on the CB device and encodes the stream ID
> >>>   (SID) in the upper 32 bits of the returned DMA address, following
> >>>   the Qualcomm FastRPC convention for IOMMU address space tagging.
> >>>   qda_dma_free() strips the SID prefix before calling
> >>>   dma_free_coherent().
> >>>
> >>> qda_memory_manager.c
> >>>   Adds process-to-device assignment: each DRM file (process) is
> >>>   assigned one IOMMU context bank device for the lifetime of the
> >>>   session. qda_memory_manager_assign_device() first checks whether
> >>>   the process already has a device (reusing it with a refcount
> >>>   increment), then falls back to claiming an unassigned device.
> >>>   qda_memory_manager_alloc() and qda_memory_manager_free() delegate
> >>>   to the DMA backend after resolving the correct CB device for the
> >>>   calling process.
> >> Oh, stuff like that is usually a pretty big NO-GO now.
> >>
> >> AMD has made the same mistake with KFD and it resulted in a massive chaos.
> >>
> >> The DRM file is the driver context your process uses and even if there are multiple DRM files for the same PID you should absolute *NOT* share anything between them.
> >>
> >> The general rule of thumb is to not attach anything to the process using the DRM file descriptor.
> > A couple other things to keep in mind:
> > 
> > 1. drm device fd can be passed across processes
> > 2. virtgpu/virglrenderer drm native ctx is a single process that opens
> > the drm device file N times on behalf of N guest userspace processes.
> > 
> > All that to say, Christian is right here.. drm_file is your context,
> > pgtables should be attached to the drm_file (potentially via
> > drm_gpuvm.. which you perhaps want to use).
> > 
> > BR,
> > -R
> > 
> >> Regards,
> >> Christian.
> >>
> 
> Hi Christian, Rob,
> 
> Thank you for highlighting this.
> 
> I'll rework the CB assignment to be per-drm_file. Each open() will get a
> CB assigned from the available pool (find-first-available, not
> find-by-PID). The assigned_pid field and PID-matching logic will be
> removed entirely.
> 
> The hardware has a limited number of context banks that serve many
> sessions (on fastrpc, via the DT "qcom,nsessions" property), so multiple
> drm_files may end up sharing the same underlying CB due to hardware
> constraints, but while implementing that also, I'll ensure that the
> association goes through drm_file->driver_priv, never through a PID scan.

I'd strongly suggest to implement a simple case and not to implement CB
sharing for now.

> I'll also look into drm_gpuvm for the longer-term address space
> management as Rob suggested.

Nice. I think I've beeng trying point it out, but maybe not very
explicit.

-- 
With best wishes
Dmitry
