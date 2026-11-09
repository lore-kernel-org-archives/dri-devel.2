Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E01606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WzAUolCa;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R+UxEOFE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2151110E257;
	Mon,  9 Nov 2026 17:23:18 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47CA210F47A
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 17:23:07 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HHHDp4001655
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 17:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ESpNqPWFmAnteWjwoKztvXmxNw7OtWFA0O3xHpnl6uY=; b=WzAUolCasX54848V
 HuUxgU6/inq0QOZTW4Lg15jvNKwou0KS9bzOrM1g5iys2c4YFa9KwgY1v8gg6bd7
 w2VFdNc8WAe91QPZlxP/zG0iI2yhUnD2KRc7XeeCAu/3/AlaWqr6+NLrxnDWJ8lw
 UGddukGzRZf0OzNExX3jSHwuiLjbkdoDWl+CE3v9PM8WbJfedlx9Hvjwknt7pAob
 czydbh1TXznM/DDlHVPQIYxXQT5jpqdhHuKfQc9UqdaivNPArsg8aP9hjhYvvjVf
 XNjWY/pE8kT1ZGLbO/ztYCvkZyNfIDVhEAL6UvP5glOu/xcqvrCM4048vFeM1ReG
 QD7Xgg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hue0rs651-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 17:23:06 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36ecd5db581so2309543eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 09:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794244985; x=1794849785;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ESpNqPWFmAnteWjwoKztvXmxNw7OtWFA0O3xHpnl6uY=;
 b=R+UxEOFEs6bsrdG2/8CyPmWGYuBwlwob8kXcPI3khSiqw+TM++YmM6OKZ41PmBOZ/W
 jrO96Hy73uBxgx0a5MsqngQmURaNsN6PezfELA1acN1mQHVMJwxEWDd2/hgGTcPz7d9a
 c7UoM9rorfgstb1D6hW0kfGYZOCG3Nd04/f2LGE9Q3ouVQGrikF5VZnZ0HUtQE6rKbj5
 NKA3gyMy6jRjz0ioZ2El/IPu+u9KBh/RtR3AFu7MfNXZhOi0qQutHuiO1zMiSu5jnFFc
 coZW6kvfvYIIU0ldRm34qN7Rs2DM99Cp5XqhM58avabtd4yxullBuhPMDTC14Toycmbo
 T+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794244985; x=1794849785;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ESpNqPWFmAnteWjwoKztvXmxNw7OtWFA0O3xHpnl6uY=;
 b=vqJO4O1sCGFlQUiuWqQVXx2wPW8uFwuUYsefhi8OnYEEMXsLaAQWkWCPQAl77y8px6
 7BSUQDNrTFJjUFdqGebwmhLhihbZud2IY4gJw2Sj518rzPnHtPZsNdtOMsczDuqg5gSk
 aPonbHn0HauNTxGgLTpO6TcHsBB7zDV4Eh8ACdD5Ss/Dq1npD9PsyGOlfy7alDAEG2C7
 05rrYHf6D74/w4Okcf1iJyCS5aEOzAipsnPRxKZ99Mo9Zg5keMXIpSGu3T6BDo9xMgGE
 vwO/ruAJvTZLt8tgwSzVNV7dZcROQw3vQB8OWoWjRmTg+FOio+i4unOE7xDk3f66euQz
 uL5g==
X-Forwarded-Encrypted: i=1;
 AL+hErFJiFKRbg5SZXndfdm47CWgraihkdlaZ60PGpCPCkqcXx8vG98+gVTrmEF0Rvnup+c3W+xITXi2WnE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z++saVeLrYellFxJ29oRpo1/ved2GlHOE6sJJ1ttrHYQIfTl/ze
 OcqgObW+9pj/winTpyIRTKy8dj29ESmCjzOszsQgX6xIUvldE10Ehq6XHku+DR4TR0wT16V6LX9
 VBkCfz+nZYYndowYUQwDv6aSXxpYcmimSBvp7j3xNkU816CqSD2YMoyUvAuI7W1KmQi/CBEw=
X-Gm-Gg: AYBFou2hgRsTHnioGlQl9uOJ1Mp93Ula5rEdSmKxAjQbgzEtyRCWjzNjhV32jzSji7i
 uMXwdqW4d9tc+wN1nQBWdNXBfJI+7edLDrGWdRZMmQuYvgCiswkgvMjlncqGvhStmCf3AFis4tO
 bP1iCZqqZyRJJKdkgeq/URxzPBhbYLbLrus3OTT39VC2X2XY/y4T0XY36YfLLV1mhlxQcHYhWBl
 jWubVyYAgfOoywzCfAodJwmbSHyHSDwure0j8NsRlx3s3v0ZM6fNyt5o+pYW8fMaxiUGSEXfG9N
 AwN4MyeYEbaqD9/XY+UbRMWwXcnTqsPrb+CkoDdNcn49bYCUNbMXD+fnGireh1k8RXVi4MFBod6
 jEyOwmpSEwLpmMOWBmpCrRySFLpVLfUmESPMd9SopAfl2PdvMtHkzIU4wCU5CCBB9FkMxi+WpJP
 baL9xILJohNPEnE59KoWr25g==
X-Received: by 2002:a05:7300:fe83:b0:36d:37c4:3759 with SMTP id
 5a478bee46e88-37255b4c78cmr7781301eec.18.1794244984656; 
 Mon, 09 Nov 2026 09:23:04 -0800 (PST)
X-Received: by 2002:a05:7300:fe83:b0:36d:37c4:3759 with SMTP id
 5a478bee46e88-37255b4c78cmr7781276eec.18.1794244984092; 
 Mon, 09 Nov 2026 09:23:04 -0800 (PST)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3726561851esm14854328eec.4.2026.11.09.09.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 09:23:03 -0800 (PST)
Message-ID: <c39ab64b-102d-47ca-9cad-f590488ee2c8@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 10:23:02 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Harden checks in BO execute and wait IOCTLs
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20261106194434.4062205-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261106194434.4062205-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WkFB57vwg_vXhMNpfN6emWEAmCqcLFzb
X-Authority-Analysis: v=2.4 cv=MpfHeGae c=1 sm=1 tr=0 ts=6af2017a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_a0-uAXI4ZKTf_5tdocA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2OSBTYWx0ZWRfXyGR2KV91l+yH
 hv5zL254Poy/QemLKAhGORMv/jlQZ8MhbStqxkSNyP3yWhlrxKs2BPzd8M+FfSOlWF7AueF3KcX
 dC0ulaHXPtWUTx65oR3nztFKuOHn5w9brfPfwYWkfNGw5nyu/LkBoaKFD27Trag901I98ByIOnP
 uR9hi2ydilcXQtTV1HbWTQUHQIMLuOm8/1xnsROvhEZlm3azyI4ccz/vnve+GLZxmHUA+Wc/LSv
 U2Xbp02Ho/9934Axz/ftjRMx6OTc/4bkppFnFsC6VgeAEI+5ozk9YTWjNfVa0TEEzg44WHvueuZ
 YemkPYZaNxN6eEXiGf2NohV+++qrn1gInEUHm9/5Mar7q4i4jnd8q4KavSZ6TcijTpPPAX4RGXr
 CDYrNhKX8bJMIjgodr9Hfu4cjdcR7nX1nlUuf2YLn303rAVUthWKhQDfII1Ky7enle7+FFHmXVc
 jFBB1hyRqVE2vK3lsNg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2OSBTYWx0ZWRfX0b0eb2ItZ7Ak
 OLnTeKO6F/5lb10XTSMUBGBL/YuoZxgTFX4pxCDl6HTQzRi+QmxaFgmVSSaS06WFnOzO7Hjv9mT
 Rjzgfa2gMs0Y/2ugWso2wO8ADb47vN0=
X-Proofpoint-ORIG-GUID: WkFB57vwg_vXhMNpfN6emWEAmCqcLFzb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090069
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/2026 12:44 PM, Youssef Samir wrote:
> send_bo_list_to_device() does not validate if the BOs the user passes
> through DRM_QAIC_EXECUTE_BO and DRM_QAIC_PARTIAL_EXECUTE_BO IOCTLs are
> attached to the DBC provided. This allows the user to slice and attach
> BOs to one DBC, and execute them over another DBC.
> 
> The same case applies for qaic_wait_bo_ioctl() as well as it neither
> checks if the BO is sliced, nor if it attached to the passed DBC.
> 
> Fixes: ff13be830333 ("accel/qaic: Add datapath")
> Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
