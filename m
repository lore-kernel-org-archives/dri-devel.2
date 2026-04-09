Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245FCF364B6
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 20:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 780F410E861;
	Thu,  9 Apr 2026 20:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="erglGhfy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TBzAcyxs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 765CC10E83A
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 20:52:18 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639HkJmH2698258
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 20:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4YgjMxSPty1CRZ5O2vYOSJef2/ASxr164jwUcV48qCQ=; b=erglGhfyWNLs2xhs
 hqwT5Y0E58DH/3rzJnDP8Mb0HJYivfLS9OHlovYOb7XIpm0WPCGO1USuxhcnKLEr
 G3s2Dnt8gpIc+OFwenIsc3J+ZHs22ECsu0M9KGnxzZdlGkkzKa9iYR0xcC2l7ae3
 ZyMsno5XuK0Y3TRIhiVZAZlSASFSycf3QA0TNOOVrvafXAujeq8CTwlIk8rxeR7S
 NIdc+SoU0HHpJYUHfmdE97nMzCmXjEnm40+f+D780Di0pyU36k7fSB1VcvmgC26U
 M5OI8OubEVUfqFIexP+PCh2S2k25C47qvoH2yXvd4NFpeGL8koDnHNwzggv4zkOl
 /ruLiw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4degt9rhyu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 20:52:17 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2c68a134df8so1137890eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 13:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775767936; x=1776372736;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4YgjMxSPty1CRZ5O2vYOSJef2/ASxr164jwUcV48qCQ=;
 b=TBzAcyxsonD9E7Ra3TnfWxrPBWtGZYupmAzFDzBAGEjN1Id3I+ly13TQQATdMQ4CpW
 Ma6gFgZ/ef1Q/PicOtsKNmBR07YMB9OH6FKTbwyv8gFPTF1AYtMT4hba7I8sEISynFRQ
 QaDwkaAaJaOtSABLy07B38edzluoQ24TS+64ykdhc9ODMAKctrkMqCByGxmO/QxP9g43
 JbfLAXtllPAH6Ld6gtHG4jhRHUBIm3w4qD+X+SAjy6ce1cwc1+pHtHVRk7S9ak33Iwi0
 u/bsvYpsrcZZc60VZlO7b1mJfjSg13i5HCS2c+kZZVwh4y9Bo5UmPQFQfBCH3MbEaKTU
 kBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775767936; x=1776372736;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4YgjMxSPty1CRZ5O2vYOSJef2/ASxr164jwUcV48qCQ=;
 b=ntDjAM/eZxrGMe/01McsYF9kmJE/4UqJvTd+N+jzFDDtNiCiNwMUiLIzmuvWvyEhyJ
 lGjU5m3FR8IT9j5vNP2LAlJVixYiN2Qp8BJHOuWM4duvY+fvuGKq8Ovw3wrtv87bPfMi
 4N/8n47EB5SP6XQB8CBbjuXr5bFQehnQGGb2xyGRFxsQ4TINWaTw636twbfuMyhLnIJz
 jQE50w5FtpsRIYEuPnALfMPto73UZj75ym/CD5ulwJ9zUzFRnmcmt808FfIVHelQQole
 /uUmKSKmu6uGGdnzRNs2PVyg4JjmhAlkCIYqJJLCVPqba69ptZRoCQ25shGRvwasafN6
 7TPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkGpMuwFXgsTJmyQTcFVTrb0eIAYD1SOSzGvm2RUAvc61PKm5tkG4U/EljcF9eZg6GzYfT5OY29d8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwK+KCs5OZ4jOylrldoV2sBdz9juGAGjfA27InUn6dHypHY7Rt3
 f6vpZJBwZLgx1pyox/0rjzWXIXY6CzI64FRoD6KcmJrWhmhoEz2qRcnzL5d6mKP5itS0XC8A3YH
 5IN/NQD1oqoQ2w5f13IQWTsrXoxEYXoIBdQq8PLB5xSDxk3gpp7uJPZM9vTYulG2fv2wYuvg=
X-Gm-Gg: AeBDievUwBlBwxOcvS1yWvUacxAHZFdrW59s0aLkGV8EbBXFmX6jpsc9QhnMtt1yET+
 q9Z6HsnZ5/k4e/cV0ZXP0KQxunotl+TH0OCkpJE5lL0hRIg3HC52jJh1Qj8UUOlAl+9I8LhS4Op
 GXbMyA1bTqCh42yBas9BvAnk7S7mfstQOL5LOdvbCnc7sBzfwn3RlbVlPMoUAn978b2q8QR8xrq
 +7HV2W0AtF/ZB3zPXp4rRoJUlD3k+HUyXq4unEdjst/jqMe7eK9s+BbLPjUYZRzENL7iL6DAMpX
 EQA4oPXwtpiGJr5ttS17psWMIn/mvHA6CKdOSts5V5SVBpDg7Tl/EqZWUeZsS1m5FJFsS52dT/f
 rJqOfISioBg43E62/8Lob7XL85CNg0iKLfvrnds5pEKL5fNCOI3hnIXr0HKGONCs6dDoFKjidWD
 w=
X-Received: by 2002:a05:693c:3117:b0:2d3:dff7:13ba with SMTP id
 5a478bee46e88-2d5871afaa7mr376373eec.5.1775767936367; 
 Thu, 09 Apr 2026 13:52:16 -0700 (PDT)
X-Received: by 2002:a05:693c:3117:b0:2d3:dff7:13ba with SMTP id
 5a478bee46e88-2d5871afaa7mr376348eec.5.1775767935665; 
 Thu, 09 Apr 2026 13:52:15 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d5632a64easm1452705eec.31.2026.04.09.13.52.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 13:52:15 -0700 (PDT)
Message-ID: <2eda7d10-e4a9-4ca7-ae73-bf9c0ca8fa33@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 14:52:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] bus: mhi: Centralize firmware image table
 selection at probe time
To: Kishore Batta <kishore.batta@oss.qualcomm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-4-47ad79308762@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260319-sahara_protocol_new_v2-v4-4-47ad79308762@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE5MiBTYWx0ZWRfX7bSa29/XuA4s
 AqpUe5ZGMQHLg3ikUdLBun3YpEOoZ20+/pzZSouDg5UAhmRbqDJ2VR7EhmkyuTwpsQjjJ28ujal
 rGLdBnQJkdlRDGj8iFhfCiBTGtLgZBR5CN6LtVkRCSDLwvzOy7xlJl1sK1nV8KZ+VP40D7yK0rp
 LK0my9Fi++s2dq7OQVwkltfWuWUYZSoarSIs66sncmaVP/QPsQPhqOLQSlvlrgvmcKHeuToXlbK
 vKi8awMDm6tiJyRlYxFsGGKCweVV+49BcIeF2WVYPA18NDvw1Dv7ILWMti8Dng19WSGhHL2Nxgn
 p7IxiQ1+UWaHAqaSW6GNu0D64ulz4iDKVuUcjsYVVe50HpfbTHepOB2e6DidscNnfZaTGEmNq7h
 Y9dOoD5ZxQZX6z+zsIEUOIscB8cx58A4aBYzpW85+mbYonIoUgFsQDNfiqJ8OH0ixzaB7lPD7rk
 j/2v7GfQHPyQ2E+2c5w==
X-Proofpoint-ORIG-GUID: xOmOocshgL89nHEN_5y097VSDolGvEpJ
X-Proofpoint-GUID: xOmOocshgL89nHEN_5y097VSDolGvEpJ
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=69d81181 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=AsT2qU_2Mam4ECEOgGwA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090192
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

On 3/19/2026 12:31 AM, Kishore Batta wrote:
> The Sahara driver currently selects firmware image tables using
> scattered, device specific conditionals in the probe path, making the
> logic harder to  follow and extend.

"to follow" (remove extra space)

> Refactor firmware image table selection into a single, explicit probe-time
> mechanism by introducing a variant table that captures device matching,
> firmware image tables, firmware folder names, and streaming behavior in
> one place.
> 
> This centralizes device specific decisions, simplifies the probe logic,
> and avoids ad-hoc conditionals while preserving the existing behavior for
> all supported AIC devices.

It would probably be useful to mention this is in preparation for adding 
QDU100 support, otherwise this reads like it is just change for the sake 
of change.

> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
> ---
>   drivers/bus/mhi/sahara/sahara.c | 66 ++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 58 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bus/mhi/sahara/sahara.c b/drivers/bus/mhi/sahara/sahara.c
> index e3499977e7c6b53bc624a8eb00d0636f2ea63307..8f1c0d72066c0cf80c09d78bfc51df2e482133b9 100644
> --- a/drivers/bus/mhi/sahara/sahara.c
> +++ b/drivers/bus/mhi/sahara/sahara.c
> @@ -180,6 +180,16 @@ struct sahara_context {
>   	u32				read_data_length;
>   	bool				is_mem_dump_mode;
>   	bool				non_streaming;
> +	const char			*fw_folder;
> +};
> +
> +struct sahara_variant {
> +	const char *match;
> +	bool match_is_chan;

This is dead code, add it later on when it gets used.

> +	const char * const *image_table;
> +	size_t table_size;
> +	const char *fw_folder;

This is dead code, add it later on when it gets used.

> +	bool non_streaming;

Please run pahole on this structure. With the interleaving of types for 
every other member, I'm expecting there would be quite a bit of compiler 
added padding.


