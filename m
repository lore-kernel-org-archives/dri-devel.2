Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F67AC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A40B010E640;
	Mon, 17 Aug 2026 05:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZB+O1Wf5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ERw4+9CS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F98910E640
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:44:47 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLEaHF246919
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=DxIV54bZW0mbknxQlawpAwW+
 cPAeEoPsp3aYvzyr9hY=; b=ZB+O1Wf53eu36mBtTwPud49KO9hQowP2gfnqPgwE
 2shvJmDSi8qJt95K4SnQn+tyaY45tCdf4ZJzHSb/H62tfWwBX/py+yXLoG1Aq1ze
 vrGICIKVmH2QZGLg3CXfySNST6xBwDI1l4E+6lOz8Uq6kjDJ1I8iZzMwp7E/CtSl
 notJcVzkiYG0MEc1Dmjezk/FlFAmf47khwLJA9xeJLp1hnS+cPQ94KNNCiY9c0oC
 U7U/GsExkWKnkQvDcRF0aZqXTv7GfOkm4wgsmUtmSp9zk9IUmdQY4Z61fR9b+4+N
 TYENKCzlYJXUcJ6Ub0KcwZ0FD3fYl+H++JFzkgr4z3sLKw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghf5b8r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:44:46 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51a8db414c7so43483181cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 22:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786945486; x=1787550286;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DxIV54bZW0mbknxQlawpAwW+cPAeEoPsp3aYvzyr9hY=;
 b=ERw4+9CS7x++pC4DpPNSMGOW6klCBF2V5bU4UUIl2i2OnrwJxTbIpQ17uR9nPe7mad
 NPhiMiFq8s99S2mIsPxnu8u2lcrSJeQLnXZV2QA6TlYctypiOecBUjVNTVD0MD07zwUa
 gN0rRLiCi5IaCsy0oXqH0K2snKbbYioCUGuysVuDCdVEARrjIygYs5+GI6RY98EQ2OXt
 tnW8/D1Ihah8mRaqlSrp0oE4prqEMcEqVuQrtRz3M0phK/LE4TInApTH8X+TCoxEpPTt
 FnhbRF+uHHZ8TOe7yWf838jvcuJlzrKzxr3XSti3QATTDhmp00mdJrV7sPpiL00LsH5u
 HaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786945486; x=1787550286;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DxIV54bZW0mbknxQlawpAwW+cPAeEoPsp3aYvzyr9hY=;
 b=JDzzL2zVo8CpvizDQmc9oC6QtPQbU7z0g+jWcF/TBsBB9WsgZhj4xkSzeyxehhhJL5
 G6kPkdfgEGkM84LatwJP1UYNjtJZ18wugeDtq89L/o4tv0/1ZfSoqPhH4ZnzKEX6Xjmy
 rRZOLC5aPfyY1M5gDChhATBTMXMoCjKKeqnsPVruKCNNnQQu4RXPu5O65A0ezbWwHCvE
 +SwbVmolHGFEOK4VBz7hjohnmxrP32+5C9s5GU2jI4Uxj5rtZFlM5hCnGN7Eyw7dYVIH
 iIu0o0rbvQDEz0MmxjhMy9Sj60JFhj+87XjQQgAdGukRl4VisMudh+4KTncJRnNGRsZd
 A/vQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKtxJk/hXY2yoUA2qu7V+5DbfkNlSIq/Hvf0KwtIl+XGQ8a99XAWyCzKqfId62gAp/kC4acIfPteY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGrDvn96M7Vgbc6tXDpw93KsTDSHmzKE5drtIY3QcFZLw2UFNe
 yDGjI24x8kOREAKGYLZbdreQW+yW5XDm/WfJP7fSWamLkY0BJbmNY7t+ITQ+5CX2Qac6t+l1N34
 1tDZ1D0wB/5QtBU41q+GJZ0vSVNtEasyIlEyb3MAPYDT/Xo4AMvfAhRI3XMUBnBL0jiYjxU0=
X-Gm-Gg: AR+sD11ALBnNBu5NpQh+ymAPDH0lIHX8VoaAMbASZBZkW/5lXy06zSAtnQWmAEeNN+7
 IwTfq24qVSlH9NVrcwUsXrGFHAQBd1jpbn62F6KKQZ1b/W/4onJS2karXbHi526n9XnVFEQN+HW
 Hv5ygiYhT7jkchG4AMay9V9I8BYIJalbLQ7QAXG4XqPPzT5R8uL02FU3qYX2x3NEMUKfOml7LfR
 oi0ltr8exs+0Dm2ynmdXo/jvYB/6vuLaCHDsBDTIElKgTkIxMKk4eosDmMnpL08gQ6jLb1wKgUH
 rFpSCpX9RT64U0AtS0du2R1n6VfTChhcMCtSd9wy3Chza9lpoq+mEA1LG/vA0oKjwWZPTa/x74l
 RwlRAyd0CrayG1WYmOQxn49gs3gPatCqsmPeTAtSrkUdSVq8zEpatk033r+MqeZXS4J1SISQKYK
 wG71R3MmCl+vF4
X-Received: by 2002:a05:622a:8451:20b0:52d:882e:4986 with SMTP id
 d75a77b69052e-52d882e4c7emr139157171cf.4.1786945485921; 
 Sun, 16 Aug 2026 22:44:45 -0700 (PDT)
X-Received: by 2002:a05:622a:8451:20b0:52d:882e:4986 with SMTP id
 d75a77b69052e-52d882e4c7emr139156871cf.4.1786945485468; 
 Sun, 16 Aug 2026 22:44:45 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b46cffea7bsm89313e87.50.2026.08.16.22.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 22:44:43 -0700 (PDT)
Date: Mon, 17 Aug 2026 08:44:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 15/15] accel/qda: Add remote memory unmap from DSP
 address space
Message-ID: <6k6ogbosxx4z5bh7uriu4fnj24ycuakylq6g2gnuwsbckl2zww@e66jgj5xo52o>
References: <20260817-qda-v2-v2-0-757ab8ed2f64@oss.qualcomm.com>
 <20260817-qda-v2-v2-15-757ab8ed2f64@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-qda-v2-v2-15-757ab8ed2f64@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=QsVuG1yd c=1 sm=1 tr=0 ts=6a829fce cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=Fyn7aR8NovT3rRngz-oA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: QnnuH0XJeRjh3VqPsJMz7OlAo5gvMVNi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA0MCBTYWx0ZWRfX7gy5sSIkxPra
 ffYGxYaWETDoGki38Q0qADgSEKVw5QGeQeck68O4Ht1Lb92adRrP8/6EL7wYvn2vfnzJeo3RFZu
 oaE0C8jNXoyY2J8qO6sUf8nN6r5F9NvCTnlTF+ccTrYR7haA7nvPwkrTU9kFKAmByRjYxEN15NF
 w9rVr6GAbLxYu8YsxU7GqNBdcA2ZrIymSoV2LVgxawD/q2TL/UvoUBP4TVrOYvpjyLA9Xe1QJrD
 XVcFnGhG6XppidMeq+DkTB42HLF0FeKUgMaimao/LEk4efba2jq2/W7ThP5UVt+X77qYSmphCUe
 dJnfwszn6HM5W5u1qtSo5GNYkBmFNB2HnEi50UbtFU+XWLRwXUmq9x/FH6VksWUZmsoxqde3APz
 nLlqV9Oe5CwRa1XjG4CKOV4FiLfvTn1/MY1wXONvhuQj8OLm8Geldd4ZXiaXe6Q6qkEXMQlsF1K
 ftUdIlsR1mfBqcSXg1A==
X-Proofpoint-ORIG-GUID: QnnuH0XJeRjh3VqPsJMz7OlAo5gvMVNi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA0MCBTYWx0ZWRfX8UnNfra4wE5H
 AZLQXNIR9JKCbfhejgQEFErIqkfEb0H+IiiDpwhFSdZV5l+Lkr8HmKvqUsKveQ/Ew5bfMtE+wDx
 52v3aZz8Lhhi3OYf6Jk3uYlQvYykkvc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170040
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

On Mon, Aug 17, 2026 at 10:38:45AM +0530, Ekansh Gupta wrote:
> Add DRM_IOCTL_QDA_REMOTE_MUNMAP, which removes a mapping previously
> established with DRM_IOCTL_QDA_REMOTE_MAP from the DSP address space of
> the calling process.
> 
> Mirroring the map path, the DSP exposes two unmap operations, both
> reachable through this IOCTL and selected by the request field of
> struct drm_qda_mem_unmap:
> 
>   QDA_REQUEST_MUNMAP unmaps a region by the DSP address that the
>   corresponding map call returned. It uses the vaddrout and size fields.
> 
>   QDA_REQUEST_MEM_UNMAP unmaps a region by buffer identity, using the
>   GEM handle, the DSP virtual address and the size.

Why do we need two different operations? Can you just pass the GEM
handle to the IOCTL?

Also, what happens if the buffer is still in use on the DSP side? Will
the DSP crash? Will the whole board crash?


> 
> Each request type has its own argument builder in qda_fastrpc.c,
> documented with the packed argument layout the DSP expects. Unknown
> request types are rejected with -EINVAL.
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/accel/qda/qda_drv.c     |   1 +
>  drivers/accel/qda/qda_fastrpc.c | 119 ++++++++++++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_fastrpc.h |  34 ++++++++++++
>  drivers/accel/qda/qda_ioctl.c   |  22 ++++++++
>  drivers/accel/qda/qda_ioctl.h   |   1 +
>  include/uapi/drm/qda_accel.h    |  39 ++++++++++++-
>  6 files changed, 215 insertions(+), 1 deletion(-)
> 
> 

-- 
With best wishes
Dmitry
