Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8BA606EDA6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NXsK1e5Y;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j15iRj63
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6A9A10EC72;
	Fri, 13 Nov 2026 17:35:53 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C36110EC72
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:35:42 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFRSqS3296068
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aYZIOBn5BmRcgUyZSRiHsxOFf0KM9EFp+lSaex6vXAA=; b=NXsK1e5YNhI/JbZK
 CAHAHL7xlq8nL4W/APJ7A5SnvbBkcKYS/pGl8lb56IAorACD5aTCnxZZzNboq8UE
 /089MYlFasj/cnv7idMAyr/smsU1IS8aoZomVMre4vicdrRc88azOkg0CxKlduAg
 cV3+MBL6ttp/rL8VFine6J2Axlv3l6RSfSFQVK9NcsdN2ZYPaqUry/Lh2v3DnzEN
 JKsvsLO/bG449YakWvxkm9jdNY7EPIneHVaJ4hbed5XtRKGOesFmISU3wwH9l3I4
 6JBmpwF3x3Q99SoyGRExnZhrpPYFGwnDpUKze9ZASWGpWycbFr7sN0TmNDSJ9BQ4
 Jc9j8Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvu6td89-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:35:41 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36a3451ea93so1229668eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794591340; x=1795196140;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aYZIOBn5BmRcgUyZSRiHsxOFf0KM9EFp+lSaex6vXAA=;
 b=j15iRj63UIN+eYJc0Jv4oDl3SUQo+r+7cEvmAb9mfxmwKYguZrQaMXlCC7RuJjiysj
 l8B0Op0+yAIv61T6neiN+Gaj/7mYMs1aiBs3v74Irrd+FcWks8BnO0k0QoZ+UhmDetL5
 RL6ZIKykVhyHzlueX0YZ2GUXQfbGdB1zK+acnq8MvHCAoGa6WoQGoi0Ebj7rvd3qkCqL
 AyZknmVNYgnbQgn8QTzX7P6ZHuLq4zuQb57buYRmS9M6YRRUaOfw9SCEmhGbDMR40crM
 FFLNKvgxsfO0MuoJl5IaF3UKwNzUH2oWRSFW39NAUwloXn8EXp9O1nj+/TTi1GGRsSXM
 DIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794591340; x=1795196140;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aYZIOBn5BmRcgUyZSRiHsxOFf0KM9EFp+lSaex6vXAA=;
 b=zR/r7IVvtDXxpEM23TuDADSSv3WoEr6ZzvitnFLlgwb87g1LGyi2UVM3+m96oA35en
 Pg18uZOL2ic6BJ0KHfkqqlSbudl+hswkfm2gV+LzZczP91j505IzzNLoTyDepopXSnWy
 MyzRfjQSiMWbplCZomWT88dfguaO22jA9HXI2N6WuaPlTyRNNLyBTCjopLoqPpy+rf7M
 i4jYWh8fzjJeJuJnIIPb+t05Ra/y+kfaBCo1E0vI3+fOC0krlgbqXDElKvioEqRJYSFM
 KYfSolnuOfVB5yyfKqon1+QekNf6H5ugCsAcMhxamLXMf2OcdsS9N1JCkQroF9V4yTvy
 bzBQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG0Y+Qd6EtaWDF7UyS87qowuS+h5sX4RiwOgz4kV+2rC30JQAHWgNmUQ0Hpz4Blqhjc9rzdW2z55cA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/k4W9O24ZRctOG5Yjm58gScihURwJuLyDUUXubcd9jpPwx5UeH
 JhmGMQnHzlsZURYdtzBNbV+4VBfIrucEvbdVAMf3hTwlyVMTxMPxzuDnUF04wRC33rYhcB5p5AK
 6DHLY9HQX5UKXQImFDu2wGRix/FxEtDELcwmUbQnrqei8+oiOKGm06wHuIY216Boa29E7YV0=
X-Gm-Gg: AYBFou0wCWBnLaY6YCyjT+n4odqj7c80XDo3qKxgpyDCtmYi+hQCIuDWpFdAMlqDWIM
 X5o6ZOu2EH+vbbD5KaDAGM/RvLCMiMfLRb63FWQKStzoOiAaFgt+YalyLG12kWEa3G+9JwgG6B9
 WK432rSdmB0DBKVw8fpUz2T3178th7RrLLqwk848azSQKkzZHOq2GiIH/+xLAqE4zRRAQNFF2H4
 4oQcBmb0FNWl3fKjnbeV4y0fCvlxzvCRoEXKH/UasL5JFno8OhfyhW2a5/QtoAscKSV2cj/J0XE
 t7xzDfDNvhip9jwg0szTQc1k6J3fgAVrtZuA2ACG2qPUBxl+FaIvNtLJTdzt725FCf5AkSH+eii
 q+cy/vtlgbxfgybeEPQ8fSN4LaKf7aonbQS06f6dCTeFogB2MuGrJKH/rSvcem5+Uuebey1W/7G
 v5blV6E7AozjRhs4j7lcr0B6I=
X-Received: by 2002:a05:7300:8284:b0:36a:1f8:a589 with SMTP id
 5a478bee46e88-37966e3b0dfmr2645471eec.27.1794591339725; 
 Fri, 13 Nov 2026 09:35:39 -0800 (PST)
X-Received: by 2002:a05:7300:8284:b0:36a:1f8:a589 with SMTP id
 5a478bee46e88-37966e3b0dfmr2645441eec.27.1794591338994; 
 Fri, 13 Nov 2026 09:35:38 -0800 (PST)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955f01d68sm8661283eec.17.2026.11.13.09.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 09:35:38 -0800 (PST)
Message-ID: <3443393b-65e4-434f-8d3f-2a3bf81bf13d@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 10:35:37 -0700
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfXwtRgzHJ83zsE
 YrUxPZyfFi3CNWrJOsyIt4ZPIz+N+dkJ5tD6Y+X5NWhmSmH6Hqa7L9gaNHTIIIoDuWLtmI25z+X
 UdL6yzIyOlCeJ5WF/ejPhBTQBBjlXozAyJYa3LCUMyRlvB+QgwHz733q3lEEGaF0ooBczw3/Atq
 YslPwkMjq+mNBivOsDNlWUg7F202ot8vTxo7pk/0ZrefH4KDq7+NraQ20tY1xKMU96zzokNIhQ6
 smgjbZCxQ3H7lgO5IXvqzdjP5vQHoAj7nMRggvfrfrjylWrf548zzpryvvaimxJePkog7hQansn
 loLUOG2mtIi6+cKHPvhuK9+Kw32ClSWZLCu+QuqOGQbPwX/BXROsz69PHHBF/5Ze6A4g2xAXLKk
 zHi3xpjMIHi1i+UbqrS8RDePRo/0sCM5A+vxaSytjPnDmVJENEVfwGJr5a27OmOxZOfqCUV6rTb
 f/iNwbbCV7ydUgEpizA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX1xmOYDjg6zFO
 VRrfSkjFw4WTIRSbtfaKDS+9PfacRaAY/4LK5IhQng91UayZ+OVAF7uaZJRxNReTRXztAcuMdhJ
 OwwXsspe6P7P7mj9+3jGy55Debhy0FU=
X-Proofpoint-GUID: ZKdoDGIYQcXNnbNyMMKM7bvxfJrRM_D0
X-Proofpoint-ORIG-GUID: ZKdoDGIYQcXNnbNyMMKM7bvxfJrRM_D0
X-Authority-Analysis: v=2.4 cv=JfcpPkKV c=1 sm=1 tr=0 ts=6af74a6d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=_a0-uAXI4ZKTf_5tdocA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130070
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
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
Looks like some minor typos - "as well," and "nor if it is"

I'll fixup when applying.

-Jeff
