Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7FCF364B5
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 19:47:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A506410E0E9;
	Thu,  9 Apr 2026 19:47:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E258ppeT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xwbk4p1W";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31ADC10E0E9
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 19:47:10 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639DdLb62812087
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 19:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g/06ClVKS+CLMiIvs4gyofvU9apUnpcFRIbVbc5UPFE=; b=E258ppeTaBTn5jcT
 fpDf25bOdp8etUBuri9dWIQ4KzrdxasmAACSd68I241xfpF97QvabQdVPyVnQ/qv
 21/gdNo0mRTcMj+LtHCjqcEk+N+0gKmm+VZBQ6955Cc/CTLHh+JIWl59J3Z2dqS4
 Px89Ewvg93okNdGlc7AdZcTUbtzoJYketddZTlbpqQh79enULdlXCJSeV70wrczL
 T3AQeQCsCxRS9xC9K4bWylVgmwSC27CsF9ZO7vOWAtbiMjeL+tuxeVlrvlHinebT
 TXbNN+64GRjB4hgYqyAz7MZ99QKvhR0CiLbt7B94zjY60pcja4oboMG9PLsovvwq
 Owd4fA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ded6h9a5p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 19:47:09 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1276e71652fso1792555c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775764029; x=1776368829;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g/06ClVKS+CLMiIvs4gyofvU9apUnpcFRIbVbc5UPFE=;
 b=Xwbk4p1WZN3ohbEVThYEiDPO/8NcPt5EcOXOBuJaCrmVo5xm4UCM/Mk+Kyk7WQMA6j
 +xzwgA3UtJ1MEotszH2AFrDX0GXcSJNVAwgErTXKu2ankFbdSq/eIzq4qanPTQBzFa+r
 Pj6CdQBt9a60NQCowxh8NyRbZxe9LYytoihkawPWD+98rRM8QlhxjN8x2vtFMi+zX/Rz
 DC7boiTD7m6OUscMLS00LL6ptS6RWxQjzoR0J201m6svIj+SkmhuusBwXIRe5BUxAZD2
 yPQeZTTMxHlEGpkIqXLLCVfV28x8xmyszRRRsvUuHsFGhH+qijm0E8LMsG7kNJzPHCU7
 qXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775764029; x=1776368829;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g/06ClVKS+CLMiIvs4gyofvU9apUnpcFRIbVbc5UPFE=;
 b=fRaYoyEgQ4y7n2i0gm2eHRgJ04tA650gd53++OaHMXRDqr+mIrZbsXe7pbLwqpHROb
 JYzZzj3Zp01X1kSgco/QrfLMA0KU+Aet6xCXL5a5L+oE0Mi3dlLvKUZky8SGGzyjH7Qf
 x0BndVQn6q5CZzxCpSrLfwTSLEZgdl6Cc8RZpRKppd+JhJFLRGlx0AAr4OyvU69HH6No
 KhPT/7QyZoM8raAD0Eur5Cm4FQkwcvAgvXAC16uX5nNSonZqYMzjyNJ5Oal6tc88WfSi
 A1Shgpvt02rV0YD8J00tYDWHfDVqqaI8Cs9NHyUbrxashD0wLTK078OmQPlKuJCdzibk
 GRpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLu+u1XlTD66fjvGaD1VBoCjn3lW9Y6bxAUcJjSpV5YDYLw6MwereVcLfaUNYHfjD0RZr+npDM+5U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxT8eEBzYTmnKm3MPVPmUWraasu7HCtb8QvDDngUIX/hY/Jpkmu
 6waLqtjWSixK7SwukULRFhYPrxr6Rf5aqOddTBlJSrIGAm0PvHVC40HpMWOsgOQ6hBrdqENTHRy
 +/2i2TkJ0csLBiylUXbW37fzA9e098N6DKZ4ZJjy3YK0t6LaOFPZOx5pjWrEEVHRn2mJW364=
X-Gm-Gg: AeBDieuTv6lpSYFoNB0BtIJmCKrJSjj+MVBWpyphEDosrtw7rE3aTj+aDBTzyeWISb1
 h2zJ+ybLGzpjTB+4tZvtM9DPOhX0ISZsHRTgeECgCWqSOwyHg2xolzrF9FGgP9NlXMlkQm0vs3P
 tNfoeMcKQYtcQWdY4Nr4locFm9GROnIMYnerDxGfCYXHgC/kzj7JsPo5Ny6AFBysfUSfPGodjMW
 36Pc/e86WNYgs52bgZ1fe4iHsbQOSnwVDGbLllKhzxHK5UEg1/W8YaC7lUBQMjc3lv4vMRWnaq2
 7uXAE9RJ70WURRv3/Dt1ghySrt3+0VOLEKpbKJ4lD0ZbguVARx0H4g0ssQf8+KsAfGbFeqSAnAn
 cS7svdp7X5ohmcZBJ43QeVNbbZenT/tNGSJkbvit/NmlCzCDRQ34pdDpV147F+WTiqGAJt6Z9Pi
 s=
X-Received: by 2002:a05:7023:b0f:b0:128:d5bd:357f with SMTP id
 a92af1059eb24-12c34f09283mr224077c88.30.1775764029058; 
 Thu, 09 Apr 2026 12:47:09 -0700 (PDT)
X-Received: by 2002:a05:7023:b0f:b0:128:d5bd:357f with SMTP id
 a92af1059eb24-12c34f09283mr224039c88.30.1775764028479; 
 Thu, 09 Apr 2026 12:47:08 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c345a96f0sm738890c88.5.2026.04.09.12.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 12:47:08 -0700 (PDT)
Message-ID: <a793d256-f0e6-4a95-943d-e5d85c781428@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 13:47:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] Add documentation for Sahara protocol.
To: Kishore Batta <kishore.batta@oss.qualcomm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-1-47ad79308762@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260319-sahara_protocol_new_v2-v4-1-47ad79308762@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RfCgzVtv c=1 sm=1 tr=0 ts=69d8023d cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ddSKszWcQf2y6ZE3pzUA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: XLvTVW8zH4deaQyqUDw0KOg4F7JbkQbR
X-Proofpoint-ORIG-GUID: XLvTVW8zH4deaQyqUDw0KOg4F7JbkQbR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE4MSBTYWx0ZWRfX5vpcCjR+oia8
 fpNDP+IXy1pujaItGOmnBrsqWSIZgC+jl5nNYzHwykUVBX9ixhqCqeaygJ7yExsYjhTOI9/xfXy
 /XRWPzFJ8sLnpnQ/W1w1wZ5GDf8QnkNB5o9ShOqM98RFme8EPccIbVyo2Vr0FD1X/8/EBBpaMzH
 n9dwtnWeDRVk9NJYGLDj5+cLMTPTA6j6+QLVF7MYv/wcdOoh6jIQyvTKlYMDJRLcxywfQGTN/QE
 xPVy8A8C7936hd2syXlWv3iU1oW0YLBsPkk371CBbfRAs5+I8ZzOcVWiBNbagTXS3+RKxcKJZVf
 8v+F5U5GnnBiD6yOWoFC7gsHySu9ycU4kt9CKMvbqgRMcP2I5rP+VB/AAgV09fzc2tVnaqrY3EM
 kH4UFhlFan4tudWPjYc4qPg4m1B3b1ipmobASM3QK1eD74RhsIn6/jRYOQw7JXFjXv3pfdMcgOe
 BekSyiVaEiVnq1+aqNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090181
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

$SUBJECT is not a complete sentence.  You should drop the full stop ".".

On 3/19/2026 12:31 AM, Kishore Batta wrote:
> Introduce documentation for the Sahara protocol, describing its
> operational modes and their respective functions. The image transfer mode
> enables firmware transfer from host to device. The memory debug mode
> allows extraction of device memory contents to host. The command mode
> facilitates retrieval of DDR training data from the device and also
> to restore the training data back to device in subsequent boot of device
> to save boot time.

Thank you for the documentation.

> 
> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
> ---
>   Documentation/sahara/index.rst           |   14 +
>   Documentation/sahara/sahara_protocol.rst | 1241 ++++++++++++++++++++++++++++++

I see from the cover letter that the sahara implementation is moving 
under MHI. I expect to have more about that move later in the series, 
but MHI already has a documentation directory. I don't see why Sahara 
should be at the top level if it is considered to be coupled to MHI.

>   2 files changed, 1255 insertions(+)
> 
> diff --git a/Documentation/sahara/index.rst b/Documentation/sahara/index.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..073002c15a203344524e258b2aa0a6ce839e064b
> --- /dev/null
> +++ b/Documentation/sahara/index.rst
> @@ -0,0 +1,14 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +========================
> +Qualcomm Sahara protocol
> +========================
> +
> +The Sahara protocol transfers data to and from memory and describes packet
> +structures, packet flows, and their usage.
> +
> +.. toctree::
> +   :maxdepth: 2
> +   :caption: Contents
> +
> +   sahara_protocol
> diff --git a/Documentation/sahara/sahara_protocol.rst b/Documentation/sahara/sahara_protocol.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..91204bb7d170be4fc4c85f142b8f0b93d3c421a0
> --- /dev/null
> +++ b/Documentation/sahara/sahara_protocol.rst
> @@ -0,0 +1,1241 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +
> +=============================
> +Sahara protocol Specification
> +=============================
> +
> +The Qualcomm Sahara protocol driver is primarily designed for transferring
> +software images from a host device to a target device using a simplified data
> +transfer mechanism over a link. However, the sahara protocol does not support

"Sahara" should be capital "S" everywhere in this patch.

