Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9005CCA600D
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 15:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 737FE10E0EA;
	Thu,  8 Oct 2026 15:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="f0APs5/m";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TkifUXAk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C9310E0EA
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 15:46:32 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698EVIHC2299455
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 15:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PT7VjtK9D4l5ZpSDC0wwrg2DiBAIsTr6yQauYZyBV8A=; b=f0APs5/mKKZg9qoD
 PHWjfhH4q0sI5Khxkvh+5o+LDPPfwLhvyQOZQrHQkttL0XN90UeN0qzLDqmRDawT
 PHRQNVZpBsHHZiZWq2F+ngsomcN0Xz4nYtbGfYlP4CBJvwYiBgyuDG+y4EPiktjT
 wWw/ML3lC87jsWEwdi7wb/U0Hjnu2YNft+skGP0qfxEg87iLr7NEqrwJpM7/vorg
 i4cHuRG0IdibZbwyvFqs+NsVoDuQF9DJHQpDTdXjAnQniK9NoLZ0lF/h3hGXbjg0
 HzXjY0YilimzC1qMX6THZ7TyUhDVDMKgE1VtVlEbgWoQOFvAA5rrcZE01eMm8ae3
 alDCig==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2uket-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 15:46:31 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-895241d7405so76725417b3.2
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 08:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791474391; x=1792079191;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PT7VjtK9D4l5ZpSDC0wwrg2DiBAIsTr6yQauYZyBV8A=;
 b=TkifUXAkGSKTWuuIpam5L963awEBlw0lrjfWgN1r4cj+qtPov+LIo349sDt9H9x7cS
 iXQq+Vsy6DJU0uwEm53IFSMyh2qqrTvsOgkIr7s0bge5YDo0VodFOEoIKZwtvPeyWJ2G
 sAlDphSqF7eGTiw7iZE/u4zVlAdZMt3BGsuQcRS6ScykJLh9pk0PA1EHDxeseTvLBuDZ
 B3wDusOF4iRgR7nsAJVoZJihSeZO2mV0KCWTXyXY4ND6lIYQDGCrUdynxWn2hqC+oVVB
 Z6TvDjmOrOw5pVRww3WeC8F0KCce+11GCR5TlMsFiVG2TKKN2K2CsOrmfScZLEtQPO0U
 DSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791474391; x=1792079191;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PT7VjtK9D4l5ZpSDC0wwrg2DiBAIsTr6yQauYZyBV8A=;
 b=DVscjUkYMMyLrZD5TbCTsaSvWoTPCbifmIFR7QvNnOYgTu4fLrcKhmpNV5/vAOu8Gj
 1x49N9jnlnXh9p/fF1HEAnPI2pmH1/tjfb6NATuD8+Q3vijnT7+OlJWDGv4BkW+EDg7K
 FAE3VfbkSahmLXp3nS9gm9Lxmd28FyHTd+3datSei6C9k630MuUzGJxU0KcxWSjAuT9t
 MufqPxksFQH6f9KSZK6glmyx3XHs4ZqjnuU1zyZBl6WVle/nkTIK1QYTPNJDio7qyKdy
 e0P9TASnNOIC4UQlTOSgsiaowO0SnYCMFehgzAeKioa5U2jVERi9Z2wKsfBSNh11U0SK
 tgqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBymp6JXXOUTDz8gtwRvEXTusoeJ0ya9TrGvjDisvKvJigO7+ktE6P1wn/27zZoQUNvj9sppQaPdY8s=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK1OS0f/9zuWwy+LLljJyO6eua1GokhnEO4CJLgNu4bAi49plQ6
 dDPTvakaY7brGJ27rPUmEM3b+lI//cDM1EpfLk6CtCKgLbN9yb7YMxqnBbm5B/+O6VuLyTZWNZM
 qkFcbRBZXzN+i1kTunehflHyTTyZGK39ur46WBVh+9VrdzLte5rdbGrnWOco6Qhdp7N/kgLo=
X-Gm-Gg: AYBFou29JKbCts7yiv1ZiQa13bNqr3zyWj1kyD6AOcUfDEyPlQVE7nloEd/f5lbU1VX
 caMX6qCMqnU+Mwsx1qTjXXrrY6xWz/pTdOVlHMnD9dcOQidtTZ95l+GTzjUWUhVjPkwvyCo9Ihn
 KfoYVHhTDZYCgrHh1RVrnU85gvz/ESc68DReyFCuaaXdptv6t3pLNXxPR72EKjX9+CvG63mpjq0
 qe594dwHv50aQvBXy80mIyhToAbKGHJEIiD2mruOBZlV5j6uev5qadCdhJphVsu+sBynbjF51KM
 k5yyP+CnZ6DTs3Oyx3LKMMwsIi6pEwoVaynZtIXxlOhp7vxWUXERVAVKo5dOxO7qMxxj4YP2gZA
 45HhCejwIeJ06+1HwgE1yAWhq4KPZ/PsPf6oUJdLOJpQviS1zFw==
X-Received: by 2002:a05:690e:12ce:b0:677:be91:d866 with SMTP id
 956f58d0204a3-6790a2e5324mr3315418d50.47.1791474390603; 
 Thu, 08 Oct 2026 08:46:30 -0700 (PDT)
X-Received: by 2002:a05:690e:12ce:b0:677:be91:d866 with SMTP id
 956f58d0204a3-6790a2e5324mr3315405d50.47.1791474389747; 
 Thu, 08 Oct 2026 08:46:29 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6791afa70e1sm1412395d50.8.2026.10.08.08.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 08:46:29 -0700 (PDT)
Message-ID: <70101d6b-8851-416c-9cc4-f4737304638a@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 09:46:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] accel/ivpu: Improve IVPU_TEST_MODE_FW_TEST handling
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, karol.wachowski@linux.intel.com, lizhi.hou@amd.com, 
 dawid.osuchowski@linux.intel.com
References: <20261008100013.3006983-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261008100013.3006983-1-andrzej.kacprowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2MiBTYWx0ZWRfX97vSFGOPhjrS
 spvyK2CU7rYv+WKQnBpr47RpAR1dNAJs1Ef+HQp63l13sIFNEtdUlZsb6TYKKYKbCFAe1tVDiqJ
 ngvZBdr8QVcNK23Cj69RGVMyujZipk8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2MiBTYWx0ZWRfX17SUWBOocXB7
 lC7+MMW4Th8d8a3CseO6CjfHg3g/SA9kbNHR7OmQgL5/udfI/7pK/vHGflHKbD07o3cmpmiPDxf
 oE9N71aYoWHPuGfHN0KSSUocBLAabjoK8TfiyN1fVnCY/V8O7cDhVZqmVZMC7Dmg2gpS3xECWSK
 ovLTWddt/DjlibeKPsi0+KofUbZTzjGVUDj5EyJotiX7wAePp9icQn74odCDgKuuLnHCRVWrKsx
 A9aiho9uZRlv8Oik9C/6/nQHyhY7GW/saNe2yUMezdxsT4sn/7X7CXw+DC3BOhFSsTbA+aIaZuI
 Fnom7wysXjHOdPmfCTUzW1vZeMbtFXq2ymX9Fb0t2cgGIPmLVvay8G5lBPibQIHl6/MYFt7OrbQ
 xm38X5n1sPPjDJ8amOpDnpULEwS2n0mp6em+z4QiJ/IKWAK4tSrr4FTi0qx9pCGnxf+8V/UbN4x
 7xofKE4B0DU9MMzSYVA==
X-Proofpoint-ORIG-GUID: jKPVX_ONdLMVGcnJkYrnrWRH82J6AnT7
X-Proofpoint-GUID: jKPVX_ONdLMVGcnJkYrnrWRH82J6AnT7
X-Authority-Analysis: v=2.4 cv=CIm/zhrD c=1 sm=1 tr=0 ts=6ac7bad7 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=CsahiBGshErcLx7tibIA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080062
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

On 10/8/2026 4:00 AM, Andrzej Kacprowski wrote:
> In FW_TEST mode, boot the firmware but skip the ready wait and all
> subsequent firmware communication. The firmware test reports its
> results through the firmware log.
> 
> Disable driver timeouts in this mode so timeout handling does not
> interrupt the firmware test.
> 
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
