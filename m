Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56E6C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABCBA10EC4A;
	Wed, 26 Aug 2026 08:09:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YuQ1hN9N";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hy8GkUTl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A17A10EC4A
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 08:09:28 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q6RcOX3794504
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 08:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OJXQT0c6OYFN2aHcq1lc8qaGVj0md3a70HDIO/2Fy+0=; b=YuQ1hN9NkB+j/f2K
 jM4IdS4G+UxnMIRU84VU68/00IK/Or+kzo4uaBrPFYs+NqjhdZ3MONsOrl1mXxAV
 Dwj/k1yXeXte7091lspDKCgublXsw+jOBMltcaZFLiUxA+xJ9cghEBkD6925xiAw
 N01RVw4hEZlasO1juIDloEqq5SAL1aC0P2DqultRwCzLNHDq0UH+IKYpsxjfgT2L
 BHGYYkD58l2QL0GpcEDWFPz0giEt7t4wAXs23Ej/tn6kfPB2Y7Ngp+Volbb1PHl4
 bI0WpaxoBUjUO4+HrOIgYSZKTC9LERCexEGDfXVwjKm4JelbNEFSrSYxdjkaFRzM
 HmuAjg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9smx8ra3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 08:09:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52827090cc5so6925681cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 01:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787731767; x=1788336567;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OJXQT0c6OYFN2aHcq1lc8qaGVj0md3a70HDIO/2Fy+0=;
 b=Hy8GkUTl0FEmnDYLBxO/KBOxF8wLVL2lFabITrLTIB1VecDG1+NpAjosCm0Xdbnc5N
 04XSUDWpM8VnTt1bM+o+cCFUMFzn15BJVehMr2scFJO4O+Cd4vgK56mNC24IWMefej9I
 E0s9lLWk0q9vfDy7crfqKCY5vxQQZFND5jVBD56wdyjR1YhowmUhSeXVKcXL6jFE+P6f
 jVdAiEF5M/54dgC5rMFQ2NDaGvYKtLcmyo7cilncfsNSWMnmg0bFQVGBhHrGZoHTGb5O
 NP+8NmU6LLGA8OWj72gvIrRQ6p+i0+9/h+TACrTBCBdT+xqoq1RbRkbgy8VFGOuUAP0N
 sLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787731767; x=1788336567;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OJXQT0c6OYFN2aHcq1lc8qaGVj0md3a70HDIO/2Fy+0=;
 b=mnxSHV6hBMtrZc3o8/o/79aABqluPpFD8f8oohz1w12G40ZQ2AeyPd8bWwchqp86ae
 quxveMdzsDjbk8PlH9HFmuHO+4RaCcHW/NlaTTLj+IOcjmxf2z/rYbrKSpi1cn1tJJBf
 Vy8hBLjw+9nUjNtpWqunrYVh70z+JxEI/5R4s9iWLLhxTT4oZFJiMs4LP/vo6AjnBsCC
 9v3lK5CzJmAxoUSAF89OQ4HCtn5+fTp0eNeRinSb47ilpfKM3t5+oDxxOQg3n1RQ5UCN
 88Gotu8Fbs2OYNSzNZx8kTPzZGx+H0zty2OdTBzmUd/8qBuTU3TTm3ib3ld0RFCSLMPX
 NwtA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqF/5PoVyrUsHhKmBwtQbtj1xV/JYFiQaQX5Sz8A72poL0oE+AmI/WetB/PK6EXGKQ/1zBTwZDXEWw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lyfXhNcWjnCtKSET2F751yn4TKVFUDjposmpSTOp+G30Bezyjn
 JaqBAeOupObMu9/zHSPi8Ru6GOURoeL0lC99Skm0+EiamK/zBI0ock0s+ekMe4OLzF0t3bTg1Ul
 OEp9ADNl1yOaQ4uslaVbrF7le9/onOPkbEqKpGrF/jEviRMu0XFJfQVExbJEQSUgYUr/ONcE=
X-Gm-Gg: AR+sD13kgdQ6oST9CRAr9DeEe5YDCITp5hmUeGgsbxNPlVWUyMU5/402AlbvjxxnmJE
 PQ1ctgyvydMN8UdOQhKBtIMWzoFZzezd//CPYF5kgBuwO2Kf/whyd7/mnBtdXA5W5hf9yQYaqmN
 bgAC5/ZE7oHSNlrv+lYvl+sUlDpBfT2Jn+1JUS0hMCpq/nllDWGMf2lxyR2j0IQ5SePZTgIL6qQ
 d2TCc013sermWf5/3OjjKs6LxB5GEW49vlbPqPPXe6nizigt+9FCbfdvmY+IMJ+sJo3iE5/aSjz
 KbxxWPUOaGLiEJhqDpXFjdcjQCWNiqCk4Vf8l7UeOKS6zbHFKVLVT6nuD87bv/GciHvKNqrMNWr
 Q2ZT8HdLM9sje93Oiaak3Tx0pxmUS
X-Received: by 2002:a05:622a:cc:b0:516:82e2:7788 with SMTP id
 d75a77b69052e-52e2ec1e3c5mr116721491cf.1.1787731766310; 
 Wed, 26 Aug 2026 01:09:26 -0700 (PDT)
X-Received: by 2002:a05:622a:cc:b0:516:82e2:7788 with SMTP id
 d75a77b69052e-52e2ec1e3c5mr116721221cf.1.1787731765865; 
 Wed, 26 Aug 2026 01:09:25 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:dfd4:a0a3:2df2:7724])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dc96bff9sm18773245e9.5.2026.08.26.01.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 01:09:24 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jeff Johnson <jjohnson@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Chen-Yu Tsai <wens@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, imagination@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, linux-pci@vger.kernel.org,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v3] power: sequencing: rename pwrseq_power_on/off() to
 pwrseq_enable/disable()
Date: Wed, 26 Aug 2026 10:09:22 +0200
Message-ID: <178773176015.26343.5524450275043262993.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260731-pwrseq-vote-rename-v3-1-44e60b8be053@oss.qualcomm.com>
References: <20260731-pwrseq-vote-rename-v3-1-44e60b8be053@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O/oJeh9W c=1 sm=1 tr=0 ts=6a8e9f37 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_EivlD1RsPJwtJxW0JgA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: D66NT2a4pZOmfHwtxPISO-CjXY7518VH
X-Proofpoint-ORIG-GUID: D66NT2a4pZOmfHwtxPISO-CjXY7518VH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2NiBTYWx0ZWRfXyKBdt2ulhy91
 mWn73NOIafM8NegHDyvyxOBUd05SxRCCLc3Ykb9mS1JT58uoAC6DFEi2MhUD67qIDeieZz6JfRU
 LF9DjYGjAEPLlfYIjMisdNR/07owGfF8d34tNtIWqFXqOIyEKlRL9CU1cXm3J0ba+jEUm7e8vzM
 93/u3UsX3yLx/uQEJ5/wBYVkWeGYRiJxvz5FIAj/rkfOK4rqsgOFClW8187qmL0bxW02vbX8KEs
 EBZAz8Q+DUnkFoeK12pMAaUx573zMa/TO1IWqQ/i82Ay9TVUr/DUdy3UyjT4tJuLU0ECa3oqFNc
 1WHEYRNYZJ31yGsg3wv/CMKZBYg8V4zXwM75RWgmm+GFizV9yCgtILfDSpwBXfHL39N+de5Mtku
 NH/7RTHG8u1cSE2/2spvWwXmbZ2e9vTZnaOr5QgY9EP7GiNa7xGt/uF1mDKBtybbyMfFPBLlTid
 ZpcSfGgnQJP4BWXLC+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2NiBTYWx0ZWRfX3qss0zzkAWec
 Gdj6sla5fBYIuILU4lVdW/lkxiOupDxhHMwdM5sBK+CNmcv+rGRakR/tqmFFUy21dNke/rpzLJC
 7eo1SMvUCJabrUn2QNPoDRYHzpTjdRU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260066
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


On Fri, 31 Jul 2026 15:42:18 +0200, Bartosz Golaszewski wrote:
> The way power sequencing works means that a call to pwrseq_power_on()
> does not necessarily result in the pwrseq target being powered-on at
> that time: it may have already been powered on before. Similarly: a call
> to pwrseq_power_off() does not have to result in an actual powering off
> of resources: there may still be other users that requested a power-on
> before.
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: rename pwrseq_power_on/off() to pwrseq_enable/disable()
      https://git.kernel.org/brgl/c/d51fc9d4cd6eb18ac82913d83ecf7bd8c85f71ee

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
