Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88491EBFD1E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBA3C10E396;
	Mon, 13 Apr 2026 09:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E/U1GUVG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i7Ay6Bnt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34BAB10E396
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:05:43 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63D7iNbe2743565
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vjUBjpRkT+GDE4DzKslbwRJdENH+P4t/nPg+9+ZAdK0=; b=E/U1GUVG9dhseGrO
 zjp7836sfwiLAcHhwbncbt+hPDQKUScdLGb4+nD9sFydXqa8Ni/4LbfnH9AvZ2c7
 +CJkvZ/s/m584Q1VB58ATOgqHlIlYVAJYmbL6o2ZtFmSiaarBw7OUh1PyeTNew95
 guz4xwp2Av5vY2NkopOo2w0eL3a/eBa1nQSD2ZlIDmv3rmBrvuFAkA1F3sIRbd5d
 Knqq6O4RlvFB6nmVnB77c99hZ29qBFRJdmsFDAwBAnhqA9gEtLdJQ5jsC43K2UZk
 DBn+qB3k1BdYtdpd5lM+nOMGMjZSToNA2ZmsdesBLOpU9ruNjG9v0OJ7e37UwGz4
 TqrPOw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dffk6mk1n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:05:42 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82cd9fa609aso2565540b3a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 02:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776071142; x=1776675942;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vjUBjpRkT+GDE4DzKslbwRJdENH+P4t/nPg+9+ZAdK0=;
 b=i7Ay6Bnt4Ia0hohnSsdsPfY2JVlsuLKmw5AhldixgfkgPHRuwuQ6hKC3LMdlONSt2C
 COacT+ZTza3ZvvzeRhq+af3yHouP/WFUereFkzTJnUwRHdtoB2a90wFTDuX2XmtvCWAk
 tU8d64oeGJzcI4QfeR4zyHt3yiWbfup6Iiw/qx41h1iiKc3Xaa5XId30OQf2XFbqtltA
 kglSQePLHTSnwHywDaL2Ja7S2zyJIbPc8DAxNsIIRDk/XA4RtLITVFCOhVxGdITh/Ytz
 RbKldOt9n3DP4WruimFoi/XGyLmLJWh0kPPIR1ts6kL/rIlpE6Ps75mzfKC65aV+KLWk
 tlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776071142; x=1776675942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vjUBjpRkT+GDE4DzKslbwRJdENH+P4t/nPg+9+ZAdK0=;
 b=mCFylN5yH3YdsIlASHQ+d+hRhkT10Higt7JiIhWlHzjvgYRLjWeiyho4Aq0JqSnFvc
 o5tslR2jUyIT9n1vWbDOnFfolhSHpFqB8he/AnpjiYfzJhdF6IUc3uPXXQQVXupCDS1v
 igzNFD5+7pSgjR/5a2el2n6tVOmctEuH/DQoeAA1YlGg8HQdEhYZS2xc81Ym9LG9Bicb
 Q1Jo2vycPvOxUPzTV7t/U4aQG5e0uqvQP2zRTPCFFxhFCIGgf9LNkQI3k3m/OGRglqR8
 wYMAIeBoCUjW8YFM/cqhfaerBS9q1vnuu1nw9czy3H1GR00/namsBFg7sLwCjNFJ0RHI
 1hjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Q2qCLvaT8uJ1/IxsrkXiAVAXOtOaEDP6DcpaZXQpyQ2HbMef5D08k9TFlgwZfQduVkRxmWJolS6Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRVEwkB70iNpKlovWZ8sszn+OkMppYX+ZqR/nSb4xpva3UfZUs
 Gfol7nlBOtqjSNVG4YK1wAWRnlOH/tctwx16uMBU8CfS4FBlpROawiZsT58LgOMA37j45sy5OD7
 UKRuZOg5wJ6sVdRByrrY+/n2JgmkKlJYxHfl/8hEciUN+RlUnWLul1rQ1O+Xz+ytQLxb/r8w=
X-Gm-Gg: AeBDiesCKT/HvMEl6LzAmuAPZ7PgZrYj0l+UbJeqto06Ts19Vlw6NnceemkFtRE8vbf
 WAtK6KJlDOATZdtJhJDcsI5K/NJgD1BR6buo79k4bGZdQjXeX36kOS4qfXfA/wuoXTslrYSaM/A
 MIAGrs0OEUHhlfeAnMUkUeqPPkYv/HlEDexm+2tSTxiYh+uGEzBrFh5f9zJjdF/p6edS8tQf/Q0
 y1J5sn2emuVrdo3dsF8lr/2Nkgnl6FA+NgYuVfI7U4MHiiWNOa0fIekeKNKEDaVyRuGFCdEGnC/
 qScPB/YyzajT9t7PtNKpwRZ/JKmDhD/G0VfDybAkvX0rSKpETpVatklreZJR8k1qYmTnlNREWs6
 Tm2/kLRYqGXHuFkVJEWPVnfCGxhi+Nq5HQctO3qIfncd1UQJALBwcKiU=
X-Received: by 2002:a05:6a00:918e:b0:82f:18fa:166e with SMTP id
 d2e1a72fcca58-82f18fa4110mr8670493b3a.37.1776071142191; 
 Mon, 13 Apr 2026 02:05:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:918e:b0:82f:18fa:166e with SMTP id
 d2e1a72fcca58-82f18fa4110mr8670469b3a.37.1776071141748; 
 Mon, 13 Apr 2026 02:05:41 -0700 (PDT)
Received: from [192.168.0.215] ([49.205.244.213])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c339570sm10499494b3a.16.2026.04.13.02.05.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 02:05:41 -0700 (PDT)
Message-ID: <837cac8d-ef3a-49b4-9f10-2682df2cf273@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 14:35:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] Documentation: ABI: Add sysfs ABI documentation
 for DDR training data
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-9-47ad79308762@oss.qualcomm.com>
 <4bc1363d-5785-4214-8057-4f2a75e0f8a8@oss.qualcomm.com>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <4bc1363d-5785-4214-8057-4f2a75e0f8a8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA4OCBTYWx0ZWRfX5BZsZN/hhaCs
 Lf3JFoHJB6GOARPul2gav/8UDbb1n+/+BA/c3Fgkn57gjseXXsmQr6ftOMsnaB29WqqzDk/BQKS
 H9X1HnWYv1P5ynfiR3EktqCJ/HpVuru6FiD0bjQcuYehEVORpNHmoq64fkk5lltLmenT/6QxTSK
 xLq78WhQIe4lgzU/K/45NK+xpBZCkO/2CNltAmHUnTm/QZgU6xgUprzyPrscnmY2HWldRdUhO0n
 ZSVj+KyLI2OLw5IZgztmRxscN4Mprw0Yh7K9p62cH+H6CnOlHtc4OP55P0bS0Tg2icUe/nr7bKZ
 rhQ38o4gqbmlL5Giv6EsVbOzhKC6kQF/OURaLs2c5fTKrQINKXvfuiZ6I/xI02autENSa9cgRkd
 UdsT1KUHQiekj8I6Wbu1t0crZ5ogIZ2hRjhOiMEmwMYNJ76i/sFBG2OcSLGMyiBm3Voo9lt5v32
 vSnU6p8zwedAuNZzCrQ==
X-Authority-Analysis: v=2.4 cv=YM2vDxGx c=1 sm=1 tr=0 ts=69dcb1e6 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=KtsNJ/6bKgz7QsArn2OSsQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=aPmjE-LijuUacBvKLa4A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: GO760xZiagxnYzVW1c1RRkgR8B_6-A3i
X-Proofpoint-ORIG-GUID: GO760xZiagxnYzVW1c1RRkgR8B_6-A3i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130088
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


On 4/10/2026 3:00 AM, Jeff Hugo wrote:
> On 3/19/2026 12:31 AM, Kishore Batta wrote:
>> Add ABI documentation for the DDR training data sysfs attribute 
>> exposed by
>> the sahara MHI driver.
>
> Sahara
>
> Also, this patch should be squashed with the previous patch since that 
> is the one that adds this sysfs entry.


ACK. Will correct Sahara keyword and also squash this with previous patch.

