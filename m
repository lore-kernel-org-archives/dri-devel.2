Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BFBC531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 20:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7112710E16C;
	Mon, 27 Jul 2026 20:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lQgu4Lr0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DVuQO4Dj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EACC10E49F
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 20:28:39 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RIC0Zp4028782
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 20:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dfnDuv+8RUeh/cKuM0y6F6+wWcdFDiaIhkznAKbe9dw=; b=lQgu4Lr0xnH06IRI
 8zn/Xfh2RSw6Y2xrKOK/boi9q03xKJDIMEu4BiJQW9kFn0BHicPZICCusB+Gu/Ua
 zblKX42Ds9JlYXKQxDxpmTzHmcSfDb6wdfmZgo0YWTq21mS23Lx5y5Vf7HHxqeVx
 c9tCCKnn8OQ2cmAJTQS4OYxhJyEPZZy3g6NVWZl5cY3tjpzqya7b199Bygab10Cj
 7/FI5S2eCF0SziDa1c1qykRbWn3PeLig5PF1+lhdws9QifCOPwJxrBIoG85tJtYU
 L5zVjtiSmajiwhbtstdcX0M/UXqenVnUEHtOOpu4qpjjboZANFpXImTNySUeVZs/
 FeaHHA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4v6au2n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 20:28:38 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so2096199a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 13:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785184118; x=1785788918;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dfnDuv+8RUeh/cKuM0y6F6+wWcdFDiaIhkznAKbe9dw=;
 b=DVuQO4DjIzvDZGZH5+q2s5JxZNZdmRzOnidsYbbZLrPWAdClPhi/oRNiWyLmyKM8N7
 AAX8HL2NOXjcVFMU8cT4TiBOWl8+bRMpNNbMgQMT1MoeZ1AEmEDcQck4THXo5qj81Nxf
 CZgKKQd/FgIfP+XqucLPGX+EEkPc2770gTtcakqAAfUWLYp4JAkrpbcwk1ohHloiozz8
 vY74hv5mHEPYskanAQa2u4BRz/l2hZjwhtaQ1cKZW+v16m9NwHu2Tz/NnwjQB/GUaOrw
 kRN/71MOpai/T5MMBc4JFFdZAWaSUCvB6ujoxrBa90qBXz9BS85KPuDlxQM2JngcLvfC
 aGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785184118; x=1785788918;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dfnDuv+8RUeh/cKuM0y6F6+wWcdFDiaIhkznAKbe9dw=;
 b=TgrXUoe1+swwqW/YvO78oh43mMkam4rUxY1VRRG28zst6QX9UpJLybh5zJCC6izutk
 w5K8nnO7DDuw5UDPQt3zYX1LAKLZxzyerq3dTYl5KkkoEmwKxrSPY/4XDXnnHMV4Uq4b
 DjzArE5tQQyhIVE7KyQFh19txUZfHryxAShmrBJnSQg3F83qRw1fe7lqphLpBtrLrgkT
 Sw17JjXQcL4dr74HRk5uqU+FPtgJEW/FsdD17zmq5SzHMMLdZtMBDq+p5ZUMNU9UFsqU
 jhsndWEDCrIr/pxlHmQ4S4AtR7MQz+FHqX+HEHQiBFWEjYR/G4U66frK0kXcImVDkQ/B
 0FAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqudDKUpM7U4vE17i1a6oU2s722NlhSLav6+3t0jM3doFi3MAVXEChbfyF6CCxJowEM1v0ajXLUrPE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+5TF6xPkTG8x3aDUHmVktIY7Fx3nqjkgLOcZTgjKJKHK5ttdn
 zACwbrntfNp9nBk8EmPMdtWonkQAZBsc8xixy0C2G/oiHqL6jNUIpWLMjef8v0LLtzfMkhVuLFr
 neJH2XfSzCdjpZwmfaftniIL2CwO5cw9gcVR1OCr/QZzAuig4KxKXnFvc7ZSZ+u+OPMvDKF0=
X-Gm-Gg: AR+sD104bpXfU5zEAmTLYNMuqkljfmvjCtnSHA826BL6Um3KsaKSEkSj7lLiuNGBZ0k
 YPxURKk/kH1zvLu6/DqARM0eIR/ORUbyCnEybAK2aozdO2xUYijvfWRRt3COikVR64H2RGSoD5s
 mgG/RV7Uo12uQNeq30n5UWjIjkbDMvgyayj5gDkCbwSLQb0UPxbARyaDXLPrXERlBOkBoOhN7uw
 PqDruGebZxYP6JvQ+r9HxKsa9SZRCs6ipamelogiGAOZPzAa/gCzJA+nvgPGjLcKlKgQAiFlPgz
 u0NB0s3/+rTpzYZKDnMoEenwgb/xQ9jSEe9bd7YedxRIHGnrQvBHyA8gOw4txLOniYHagEhdnmt
 DDUbYZchF63ukhGjFIJqZ/yowb/kyVqncc46V+42qsK02rRgu8/biYzgfxA==
X-Received: by 2002:a05:6a20:6a21:b0:3b4:e4f6:4f15 with SMTP id
 adf61e73a8af0-3c6c7b3d0a0mr1108978637.5.1785184117721; 
 Mon, 27 Jul 2026 13:28:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a21:b0:3b4:e4f6:4f15 with SMTP id
 adf61e73a8af0-3c6c7b3d0a0mr1108941637.5.1785184117159; 
 Mon, 27 Jul 2026 13:28:37 -0700 (PDT)
Received: from [192.168.1.11] (15.sub-75-218-246.myvzw.com. [75.218.246.15])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc415eafsm35949179eec.7.2026.07.27.13.28.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 13:28:36 -0700 (PDT)
Message-ID: <477e6f55-d6d7-4a30-af28-dcee185cfbc2@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 13:28:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] power: sequencing: rename pwrseq_power_on/off() to
 pwrseq_vote_on/off()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jeff Johnson <jjohnson@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Chen-Yu Tsai <wens@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, imagination@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, linux-pci@vger.kernel.org
References: <20260727-pwrseq-vote-rename-v1-1-a2029aeeac65@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260727-pwrseq-vote-rename-v1-1-a2029aeeac65@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE4MyBTYWx0ZWRfX2/5sa92FVl+U
 TXXepB9qcTSycq0/LLwG1SSkHggxaSPi2eOw29N8a6wdP1kdFbgCBs/nPVd1U5X+q4mJ9XK5ZzN
 ZlNv5avEl63Ki1n/ntYyniWvZOFIaOk=
X-Proofpoint-GUID: J27Sg2TrZ8qVuxcRZQDuGE00CYcnXbka
X-Authority-Analysis: v=2.4 cv=ev3vCIpX c=1 sm=1 tr=0 ts=6a67bf76 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=6VQYfvmiyQ8t40WkS/mQdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=u4B4c_klvyXDgThYlB4A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: J27Sg2TrZ8qVuxcRZQDuGE00CYcnXbka
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE4MyBTYWx0ZWRfXw41h2jSSJpW4
 2aAh98+/IIH5OkpFVq8Sg2Dkjw5/26GzMbMixV4lQw4FnkIEESkvDk6EO7bbWDHlayN74tkFrW1
 OJgfeRq7EjZPKjeEPSQ5GCcTNly6DNruHGeiZUBjyWkpyDDcP7EgXdEgec6Yw3o3uTGpXsLju6O
 NQCrrMGellihAt5b+ZfihQN7tXI9bFVj6zeqqal3paNl2WgueKsPHmMNRaIaidAORmq76PWTun0
 xPpSLCGGu4SYP2WE6p7gq+Xe0PDzt2E1odAlLbcYB4CKABBvJR6tqbLIp0uKwT40Y6JOVj203Bs
 FBb8bzvps5fPLMe2rOOz6r0FdK4ImsKb4W3Gntfgmh6O/IHpabw1Bk7vjidRJFKM+9qDpHo7RMd
 V3HDlTgycsSrI72K7VjrlnYLVEdBGdGDjB6o9Zm0gO7IC4QhW+bg5LMwguELoS9FUlfxJA+nA/9
 hN/DweYRvEW//kBTEiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270183
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

On 7/27/2026 2:57 AM, Bartosz Golaszewski wrote:
> The way power sequencing works means that a call to pwrseq_power_on()
> does not necessarily result in the pwrseq target being powered-on at
> that time: it may have already been powered on before. Similarly: a call
> to pwrseq_power_off() does not have to result in an actual powering off
> of resources: there may still be other users that requested a power-on
> before.
> 
> We will also introduce the concept of "non-controllable" pwrseq targets
> soon which further increases the disconnect between the naming
> convention and the actual semantics.
> 
> What consumers of pwrseq descriptors actually do is: they *vote* for a
> powering on of a given target or retract that vote. These operations
> could be called get/put in line with runtime PM but this could become
> confusing since we already provide pwrseq_get/put() for a different
> purpose.
> 
> Change the name of the two functions to pwrseq_vote_on/off() which
> better reflects their purpose and semantics. No functional change
> intended.
> 
> If at any point users need to know *when* the exact power event happens,
> we can provide that information in the form of a notifier.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> I've floated the idea to rename the two pwrseq functions from "power
> on/off" to "vote on/off". Here's a concrete proposal.
> 
> I'm sending it as an RFC but if there's agreement, I can queue it as is.
> 
> I'm doing it in a single commit that should go through the pwrseq tree
> with Acks from subsystem maintainers.
> 
> [1] https://lore.kernel.org/all/CAMRc=Mefxn81d0VUwmQgwFtffkL1=Er_1VQZCbC1Sa-Qph4t1w@mail.gmail.com/
> ---
>  Documentation/driver-api/pwrseq.rst      |  4 ++--
>  drivers/bluetooth/hci_qca.c              |  4 ++--
>  drivers/gpu/drm/imagination/pvr_power.c  |  4 ++--
>  drivers/net/wireless/ath/ath10k/snoc.c   |  6 +++---

I approve of the concept but am not tied to any specific naming.
So whatever names you end up with...

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com> # ath10k

