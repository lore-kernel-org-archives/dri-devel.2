Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DC1CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EB9210E583;
	Mon, 12 Oct 2026 13:21:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEFAB10E583
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:21:40 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0d472679960
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=gg2xEwxVLLgp8a6YohmCiiIF
 Vna8WCqyVDg5jFOpISE=; b=LeY1ceSLMRzrbGK0i7Z7mPYEYYJBA52eYbFUqHZ5
 lH4tuVs2C8RAmfmDdQCryHjM3W/3FncLC273SoU8DcSq5155BH80/fj/2ufG9nsQ
 SIP0qc9rZb+lNTgRFh17mdoX2xQQN+dyfa9JYhUtG31tDRCIBkA6nhqrehadIJnR
 mq5QwG0vE+eFzkB11XbF6Fh6lGR5emeefKwbKXdUwZKSDc+7A+bnrWKQuW+ju64K
 fS7XhqVWqLXk3W77TvjlYt9O/XFM32F3cK2qcdl3ZaU2HGyD/miw9l2nCqhUryZR
 K7e0WmpJdmYnXBhUrzGWSlJwQ7Fk0yV9Van44js0aRv7iQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sd1t3uc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:21:39 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3592749a017so1549667eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791811299; x=1792416099;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gg2xEwxVLLgp8a6YohmCiiIFVna8WCqyVDg5jFOpISE=;
 b=iYTtKi1+l/6OZ3Urhfy1OkmB9B6Cs7CMNExa4t7XuJcB3DmDItYEo3mlsxiW2eOLy6
 dj5pemj2xupr6eYMO9ExsTDFvp0VN/ESU7doXlGj+CphdW1sJVnKI3Nf6TR0VF1dUAMZ
 ifxlWy8g0TTPO3zmD0zO7HlPzfQcNydkAJwD0G8aIjfsWBE5cGbHvdcTGE+q9q5sxa6b
 ygwvnwV91DeXUIVIFHrs1V2NBh3vU6TZG+Lu5qeP1uT26388YThlhCWmvPxHoqhXX0uK
 ev2VuSA9F/+lmq+XMzTfh50lACxRUwlzOWSsmLwpGC4P9w9fnA9lHPUo5UeoROEoCmU9
 zIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791811299; x=1792416099;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gg2xEwxVLLgp8a6YohmCiiIFVna8WCqyVDg5jFOpISE=;
 b=aodKIAWM6zyhlTjyKzoujDtcd0iZoxuxR4CqNgHevK5Hbd9Yyv3P/8pS7EjOxHa0uF
 sMi2cyKgJ/1rhsZDdbsj/tBXcWqoluovxJdW7qz4spQ8SQziGtDe1Im0BLvOg054KIyP
 T3bhAVNSGeCu2OkvqCC5gDjphc/G1GjzS+nM9tjW6q2BMf0K1ZLilPZgigZ/Eyu15d38
 rfu/l4VNCGlE0ptQSVv+BYvlcq6b9/nqXnPI8Cn1o/Fzs65NZc7LAutSqeLsd32+bRVk
 SXlg88Ab2ORJAGEauQjs6ag8tlAO7KNeQwmejldonhVgdjFujTuX1/MnEMJAyDgMnkY5
 W/gQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgfuxlckKz8Kd/WmTXWrCoGYHL0Gmr+JOPk1j/Mz8zD8L3VAn48/gUP6gN74jcKyOnQWGb9/mIMq8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ2UCCfU6EbZCKgtPGSN0Io0nmz3ok6wsXMvCj982XTYqXqenBc
 sO0XIbvX2dJemwrJbmFxMo9rPV/W/ywnwf6rKMiOew0b6ZJMoLEwz6Uthc9jDwduH+PgUUcCKAy
 I7M5OVRF4ATOiWS47ertAx3mN1CpjaT0v6a+uBxIUU1YFmEgN3T0Fv4f5LaJe9QGhTFEuMB8=
X-Gm-Gg: AYBFou23sn4tzzL9ELJy7zq2H2lcpGxhCGMN81OTt1bLDVPrkSJV5uMFP2BQdLj7tDX
 Fao+9ynXuAOpn8usTmH73c3rWSprtjibtrRLI7xj44FfTvAXHmzEAjKctxQi7V9ftL+1HbqxDox
 n5wIgXzcjjTmjAnLARkfgiNvWqyZas1/DIeAJkvxy332jO9hK9ZVKsTuWNK2hn9FSuF6OhS//7t
 NFKFjQTRJYXIUuFN1F1aUOQLsONzDiPHKivUdRA5nWjDtNuropYopjEjkmwadO0Mzv3hJ1wIFwM
 ud//mAVHi0pS55hoWlkmeXmpsKNWrM1z8fCO5Xop3J6Gd2EmVC0lHlJf404Z06N1RmiufxOT/Nn
 1XWTKW52yiADLKkxzEudTzP5w8BTEMPL8voWQPOVTdQ==
X-Received: by 2002:a05:7022:3b8e:b0:166:fc9a:11b3 with SMTP id
 a92af1059eb24-16a1206fed8mr14144241c88.12.1791811298520; 
 Mon, 12 Oct 2026 06:21:38 -0700 (PDT)
X-Received: by 2002:a05:7022:3b8e:b0:166:fc9a:11b3 with SMTP id
 a92af1059eb24-16a1206fed8mr14144192c88.12.1791811297876; 
 Mon, 12 Oct 2026 06:21:37 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3593b8b2ec7sm19151010eec.4.2026.10.12.06.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:21:32 -0700 (PDT)
Date: Mon, 12 Oct 2026 21:21:22 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Shivam Rawat <shivrawa@qti.qualcomm.com>,
 Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Subject: Re: [PATCH 0/5] drm/msm: Support for GPU in Nord
Message-ID: <asze0jREeXmrItcs@QCOM-aGQu4IUr3Y>
References: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
 <assuimpZe3J5E2rs@QCOM-aGQu4IUr3Y>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <assuimpZe3J5E2rs@QCOM-aGQu4IUr3Y>
X-Proofpoint-ORIG-GUID: 8f6myQM15ntmZTkY-i3JpEac_DEZZ5aV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX3ZL6Natp+E+A
 8Lws4eISqLHt/ABIEH+wmQp8Z2uhha21yhJQAMlN5ZV+6h1RqDmdToy2qZD+lj6DKUNAlhEAhP/
 z6aYMD4wuA7EOXrndxEt1plA7eyVRmo=
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6accdee3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=VSReoY4tmV1E6dsv7MgA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 8f6myQM15ntmZTkY-i3JpEac_DEZZ5aV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX2C9lEfz9qkJA
 mt5hL75U2JBIS+DSeGh+q0/sAwhcJ0hVeGLl5+DGcwpG8ce/Z/0spkP7y33VHNaXlDjkaA5soKg
 6ZjwEV7fayaiKJpgsRaYX73T+kz1mZTE/6iyU7QOaQ2Su3pLGsBnwifn804mzWgMIZ97YUlW8Wl
 IsLydfMIVXDO9RYIpQGL3U5bhp8iMXHM0WQmD/CUFgvhFPhVfiSj1KQ3/XCydbIJQYgE78FNMSM
 BKbwHumRHZz/JyHnlTrhfNs0jp0OIEU8uYfUXAHRRFibpaRkHzXrNNeP9EQ2OfUZkScDISIB+H8
 8xql6/BYTMnr4qoaF/rMQGWZVTb0d4Jpjru+Z7W8n5vK6aVIIbBpJPD2yNMUbs0IIvg9sa4DAk6
 Rj11kWS7YFzL6pBR5lKQ+q4GWsMiwoF5NWSOApd8KzITQQ7tID3wN3ftcUg2gy2VUEd4hHEdQ26
 gD/K1v//KsFWkL8VLnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120053
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

On Sun, Oct 11, 2026 at 02:36:58PM +0800, Shawn Guo wrote:
> On Fri, Oct 09, 2026 at 02:36:34AM +0530, Akhil P Oommen wrote:
> > Nord is the first Snapdragon chipset with 2 integrated GPUs. It has
> > an Adreno 753 GPU which is very similar to the existing A750 (SM8650
> > chipset) and an Adreno A735 which is similar to the Adreno X1-45 GPU.
> > This series adds support for the A753 GPU. A735 support will come later
> > in a separate series.
> > 
> > The driver and dt-bindings patches are for Rob Clark and the devicetree
> > bits are for Bjorn to pick up.
> > 
> > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > ---
> > Aastha Pandey (1):
> >       arm64: dts: qcom: nord: Add GPU cooling
> > 
> > Shivam Rawat (4):
> >       drm/msm/a6xx: Add Adreno 753 support
> >       dt-bindings: display/msm: Document Adreno 753 GPU/GMU
> >       arm64: dts: qcom: nord: Add Adreno 753 GPU and GMU nodes
> >       arm64: dts: qcom: nord-rrd: Enable Adreno 753 GPU
> 
> I tested it on RRD board (against next-20261009). While kmscube seems
> running fine, I saw the following errors.
> 
> root@qcom-armv8a:~# kmscube
> [   30.192468] adreno 3d00000.gpu: [drm:adreno_zap_shader_load [msm]] *ERROR* Unable to authorize the image
> [   30.192503] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
> [   30.202644] platform 3d6a000.gmu: [drm:a6xx_gmu_set_oob [msm]] *ERROR* Timeout waiting for GMU OOB set GPU_SET: 0x0

Turns out to be an issue on hypervisor. With an updated hypvm.mbn, the
issue is gone.

Shawn
