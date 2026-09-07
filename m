Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E12FC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C5E810E4F3;
	Mon,  7 Sep 2026 13:17:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nba1SI4O";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J0dUpQcB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED9BC10E4F3
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:17:51 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AvKnk496165
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 13:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cv8iJBY4yRE1MEIJdzu8sg2CJmzOwiug90y4Wu/gBog=; b=nba1SI4Of8u2HXcj
 42GXLsEiahTBXSStCf/xp7kjPpEexL541KdjMrtG6IOPX/eqBsjTsgwU2gyxypKq
 UL+foWmbM1m8MBAJ/8RwkMud9gwIWXeQ+gSYb50GuQbhmCuI1NJXt6uc1dqJlK21
 ekjBBqo5vu6ELKq2TzR623ynEzIli0WzsvX126mo7NQc1S/ZAYH0s5UL4kggaN6Z
 S5DAZKM2o6TOlxvHVUzbYF02lXsi97y5AfWZ3uCW6+84sZAuxV9HNRBNuC7uzWBc
 nlFS1wLZex8W7QITEXNNXtDdHBzuovFaXZcfD2k2GToa55PoeBa3pi8z7WcbJS31
 Lg/D9w==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghuyk8fhh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 13:17:51 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c7a814bfc1so903145e0c.0
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788787070; x=1789391870;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cv8iJBY4yRE1MEIJdzu8sg2CJmzOwiug90y4Wu/gBog=;
 b=J0dUpQcB2vz9Cgy9Nsh9W+oi9JjWxsA/BpU1uWGs2IGhOmYfIsQ8xZWwNyeF0XNUN6
 zMsQe6Itgpx/AvwoyAw1r/t8K8p/nDR+Y9aFvtItsvzEDa8ZgO1VJDkVRBNGoXm2/QMK
 MC7CsuLYTDOt9iHxA+TP9dma/ijIAmHXfbZwqdtCcpp8leg9e+b2hLAdDxOACCdJjtEB
 W8lUNLI2v26qQexHnZek4c956da27TP/qpkC7hNRUrqOSiPOn224cZFClI08Twbz3IBG
 qb+1hT1NxJEiHMhiwaAwZSgKTQEr3M4ZLUh3dqp2EbxKzyDSNABocKON9DolRFk0p/aU
 j4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788787070; x=1789391870;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cv8iJBY4yRE1MEIJdzu8sg2CJmzOwiug90y4Wu/gBog=;
 b=J6G3yv8Coaj6qZsfxMiE6/GA1rWesiyKC/QzaI2i/AOWfX7Y9cJGtBH394y0N1SCJC
 XcKSEq2ozblZWdw+nPzya52ifm3KCBfpxvSdFI9chdYa5q+eLH2ylZugmlPuAn0iDR++
 wX1E49VhjJanEV+KLIKUncyZkFWa4BPp4cwVDZeAsC3RtZbs/wcB19VxkDygrClYUXNo
 yzG4XMpTrEFE5Terq65bV9AHaoRd8EQv/vWM7lyrok3lnDybcsneI+Jt5C4RIem8iJ6p
 ykJRsfNeezd+Q828KzPlUO6gBn/jQRvbFbh0xrlDJUDmXy90CwohtDv11yYxuUZMcflS
 wGEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPFo3NhwTV0BP/30dtXNSlX4Hx0arfwWTgec6Pd2RAz/v0tfoJvo3H8pDVn8kkBiNPrQCqfUP8pAA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nLS0tW53TMN9hOlUxMjd2lGjiu5CGdF394fhehCmGZWfgbNO9Q
 6HkolVlPNuPi4UPznSit95fv+d/BA67rwGAe0WOC2Rb0NE3i5hiEcaEOvEpBJqYEdFX4EL9Q+b1
 eIyM4DUgAxwLwiAev9SA0ppwBUzlw9Ez8QMXE6eFenOm9WsnneSk4cJ8r0NX5Lx67tob8qM+AVg
 y4udg=
X-Gm-Gg: AYBFou3NT0cr2id6sPRjg9ZzCaaHVfUMHXD4xkeo1G0gIpkIQQMoQw3HP2ksxTEmAaz
 EgrhjDkl5zzwz4t4gYCUSsesoTXgf9QpijhSK4CQQG1kHSP+fEIxBu3RjF0tsNbEyx01zxc84Y8
 x3wNTPRrCNVO3+c3K3MeLeA+QCIKI9T7aX/jxMSCyv0M45bUh9F+FlK5yqXrq0dgT/5TcgCTc48
 LOtaqHTy5XltbbV+/d7/gSOUDcaL3o6gN/tlB5Z2Ia7lKN+uWHiLQZFUgmjaYs1+1rKzmtudJVm
 TH7ZZR0EW2D6pqIqH4L0BTgPkAYD9Dm0Pv9C3otQ/XJFA0NMkn7os3U7tmwpNwEruYhcLPEU7H8
 pgkGntrokHdaCNt/XfrpZIg8nERDJ
X-Received: by 2002:a05:6102:292b:b0:782:e19d:6f39 with SMTP id
 ada2fe7eead31-78a4a483c93mr6716237137.0.1788787070405; 
 Mon, 07 Sep 2026 06:17:50 -0700 (PDT)
X-Received: by 2002:a05:6102:292b:b0:782:e19d:6f39 with SMTP id
 ada2fe7eead31-78a4a483c93mr6716221137.0.1788787069974; 
 Mon, 07 Sep 2026 06:17:49 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7febb4sm428999765e9.14.2026.09.07.06.17.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 06:17:49 -0700 (PDT)
Message-ID: <907b3c02-5487-4abe-9e4c-3053ab92cb7c@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 15:17:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] drm/msm/hdmi_phy: Cleanup after
 msm_hdmi_phy_resource_enable() failure
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, robh@kernel.org
References: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
 <20260907-drm-msm-hdmi-fixes-before-eliza-v2-1-b097cf1eac77@oss.qualcomm.com>
 <20260907130633.E673D1F00A3A@smtp.kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260907130633.E673D1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0NyBTYWx0ZWRfXxVXed6vSxgcS
 Jv1xtopZNaNIj4d1ReM3QFWrA4vWrTFxD/M7KkdpqLCp3NoDZbRbbRv+Jy5FGg2W7BAiHdAgFq6
 RE+0Ew3C87SGox7W4TbWgZ3A/tR6eBE=
X-Proofpoint-GUID: 02r6D4f9dcv_pkFteAUZ6tfdxJM95Bi6
X-Authority-Analysis: v=2.4 cv=ObSoyBTY c=1 sm=1 tr=0 ts=6a9eb97f cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=9ZkQsALANqwWZhioCQMA:9 a=QEXdDO2ut3YA:10 a=arBHhYMabMMA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: 02r6D4f9dcv_pkFteAUZ6tfdxJM95Bi6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0NyBTYWx0ZWRfX84GVQRHqWtQi
 BvCRUKTBxUCbjntz+UFywt41GmhoYrym74d7iu/QyPh5rv4MbII17JYUOiyKV0DNHYgC5BpLykK
 5vX8x1ko8dmpLXPyKGSTHnRBKCbRa6Vbt4GklefPw4ANn+uHuwF3d7mvqTlNH+fiVq70/+2UW+q
 Iov4Lecm1dle1Qiv5/N/1AFWV4T43IEGNU7+1KmjGdBVj+5woyxhZe0rAjw7VlHDEObqXnrpWg7
 hYhqowkRmIjqEhy3M7t8LWXXr0G9Sjf8TwyW4lfDuu8zG1lN0oyHEto2NDDgK1Xu+Z3LUmf0raU
 bxYHT2rsftKjedYboRLEcqRY1MZdvSB19XJxljzpKN23qGeN0krUG7IdfmY6D04zehLXkKEB+2e
 VAS9UPrRtRTRH+F2SkcAuGnZU2ieMF/lY9NrlZ4OFeZeoYwqlHb6WS2nj/PEUDJELvyXROgG3Q8
 NrCRUqhbKV/KGQtq1MQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070147
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

On 07/09/2026 15:06, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing regulator disable on the newly added clock enablement error path.
> --
> 

ack

Best regards,
Krzysztof
