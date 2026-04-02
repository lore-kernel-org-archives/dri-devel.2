Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530D0D6AAF8
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 19:27:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C331C10F30B;
	Thu,  2 Apr 2026 19:27:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hydz4NlP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Li6YwGYO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A2B110F30B
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 19:27:19 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 632G4avZ2255283
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Apr 2026 19:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wWJjPLdJWcnl06svG1a650BKOOFjyXNnL9cxBU2BxGY=; b=hydz4NlPXChLB/J1
 HuN412H9JuFAFsf5dXSaKwcogPF+YU/MWVIrmbv9+B8D3ROS8PtCMGKxp9sf2bfq
 VkQTjoKO0aCuF4pzSbfx9G17D2Gir2NrBP3r2wT1l1dhj+Eg4Cfly7EwQDQUCDz5
 fKGPiQnOVqZln42OPlRYx1L2S14A3rak5GhEB64EcIzfsWLD0jhyzT8VqKJzkvDs
 XeI7cI7qiod6aHHxk43TSvPK7HqnxWaK7It0ZkW2adTCimPGd/6jRpr76hnTlZlQ
 6S3k3vvnSXVGPV6moOVf7JjvjHhJicZMABu3EPiRtzacH+ONvkcEmiy0GcEHEM8r
 6RThWg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9n4t2gb6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 19:27:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdc1b30ac8so8056312eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 12:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775158038; x=1775762838;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wWJjPLdJWcnl06svG1a650BKOOFjyXNnL9cxBU2BxGY=;
 b=Li6YwGYOpqXxWNH04MqhRazADd67ppTCrK/CF5jemzvKu0kMBC9I6GBvqN8EJX0wUw
 NYUEEfPxreSkmCvZWg2pY6s1rN6ELV4SIPsCSZ5DlWu53xeuzPCUgTrsTqKAEVRB+v6d
 rUVr/wZzsC7GaB2Xc7dw/GRGRYnNG5jpkwfj5Ku0aYMnArz4/heQEizphVYbKq0FFeZw
 vVJOmw2QfJX83yPLBqBz3101OWkx9VDS+snBlMR4JoN+WrorjpH4FJSIE/NHXL6KqXeb
 53mHWvQIPuzj23QKjG0p4qkwBG1aOnBFZlz6tSEf8NAyvtaYGMBYYbzqaT19/wuoN9VV
 NmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775158038; x=1775762838;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wWJjPLdJWcnl06svG1a650BKOOFjyXNnL9cxBU2BxGY=;
 b=M+uGr9bWRdnZbCBmQFETWODwgu782IbcL9jYtGf+ZTlJDR+VUMaWknjFzfQgzwEQEY
 D4eS/Ekkmfcw0R0QPBpFSN+GUbkRtW1v2xC5vsAWeHQe7QMEN2QZ57FmX20o+HP0e8Nq
 lbt6yV1U11V+GmJOQP626sZHcgRXanWPYAulR26sDgX//1nm85MOZuCC05kh0KPkHkip
 lYjUq79ZJSI451FLHaMdrQttfXoqgUR7uolzkcG/7i1TRi8/gtPFipCKMg3qGOW8suX3
 KWsaJLA2Oqf6wMRkswq8NL/qmHZR5pjq6b9gMA/rgTLwlpa7VpbiIbFtmH8J3s7xauaw
 NZhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWN0ybh1+qgFwFpq6lFU3Zp93x46uctulq44qb2csHTjP7yElavcEnnk70ao9aIvWS/5QX80Fvzlw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzynX+tTH7KyntyptsSNCcMPdVcvFGHAQb/QpOF4YnvnDoj3Dbp
 I5uKt+8m81dtzFavZSkbyrwBant+4CEEYbM0azFeMLQGkSf6j7DGfl19bVPaLNeOW/bCPVslBXI
 p6kNOt2o+BAYLzRMB6clgyzade8i54fVbZufrcj5PUKBnFc8ShS9JThGiDtpBWxIewiFMu6U=
X-Gm-Gg: AeBDieujRVHrapIspw7NtUgwxNxdm3N9sDpsP2/yjvzAQdpCEwsXccAa8eX3Z5lqPUd
 j9HrupTPlA+/DsdxRGueULZa1YDta/Ru7TouMzmc0JMfbcgnXTrJmlEam2oHY+sJCg0dw/w0oV0
 piwnEpDzYXz9XsXXJxWxSTlx4f6iiMvuJSby31m963fZ3lS6JDK1vM+NVfCcjh8IXwV4HL6hCat
 E5AUn7jfATqOI+Z/ZhhlvJZ3HKQ+BNYyscEK+B7m87Q1xN5Gr+SlpFf081hQyCSOIeigsQJSo56
 dwZ5c42QTBecaiaNrPFuGM4HIfrsHf8ikOXz5v3hBlfR+kWF/XNQUAONKygLS4hIVldD/0jTu1P
 VSEEuBH+HV9C4NWaZdrmywej3ub8JtSnrc7PLenzkd4Hbpr4ojx8VwBrcdgM0SfnotiJ40RmTyA
 k=
X-Received: by 2002:a05:7300:dc88:b0:2c5:3b87:2fec with SMTP id
 5a478bee46e88-2cbfca5c3c3mr247017eec.31.1775158038286; 
 Thu, 02 Apr 2026 12:27:18 -0700 (PDT)
X-Received: by 2002:a05:7300:dc88:b0:2c5:3b87:2fec with SMTP id
 5a478bee46e88-2cbfca5c3c3mr246990eec.31.1775158037601; 
 Thu, 02 Apr 2026 12:27:17 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cc0c6ec215sm116475eec.4.2026.04.02.12.27.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2026 12:27:17 -0700 (PDT)
Message-ID: <97b595b6-9ce4-41bd-9071-b42bd23da215@oss.qualcomm.com>
Date: Thu, 2 Apr 2026 13:27:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Trigger recovery on TDR with OS scheduling
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, maciej.falkowski@linux.intel.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com
References: <20260402125526.845210-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260402125526.845210-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: V1gvIwhEa87hdSfMYNafcAp0-8GA0zXL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE3NCBTYWx0ZWRfX2oRR4vJ6wPzJ
 LF7waN1CaIh4jeL56+qRORR6CZT7zjndz0Coktepf8ZVqcFCXjqj8mH9q14a72p2jH8vO3NyROG
 TUK6Wz6JBWStvbRzTD8fZWsfxB6/bUiHyU6j6LrF9ds1Ez1LLRgKgkX94ci67TKw4KN5WTtZ67J
 3RuOTkNx0yM7e7grR93hDUZPQJ4IG9bNBxuBpLyigdhl+WedNdwJVbnBh8y6TAIQF8/Rn15qF6v
 19D9wuu9bqNSxptzlBn1MTYnDD0lCaMwLHH5/hr/oqpJQJ9Aj+yekmsXQIe5B93eZzztnl86JJS
 1QFEvs8aPtoDfM6biwTaFM7gU3n2pg2tm7F4TFDRVpJNXamC4AjSIM0CHOax3H7xAoFf+Mez5Fq
 S0RsDizTp7mmGNiIMygXJ0IFyb57rvKSbPU5byweQgleMARseLrD78ZWcbC5yhUigQNOw9T4Twf
 gj14nLyityddqTdhGEQ==
X-Proofpoint-GUID: V1gvIwhEa87hdSfMYNafcAp0-8GA0zXL
X-Authority-Analysis: v=2.4 cv=Ap/jHe9P c=1 sm=1 tr=0 ts=69cec317 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=sADs6rJ1YQ17wP9Lw44A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020174
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

On 4/2/2026 6:55 AM, Karol Wachowski wrote:
> With OS scheduling mode the driver cannot determine which context
> caused the timeout, so context abort cannot be used. Instead of
> queuing context_abort_work, directly trigger full device recovery
> when a job timeout (TDR) occurs in OS scheduling mode.
> 
> Fixes: ade00a6c903f ("accel/ivpu: Perform engine reset instead of device recovery on TDR")
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
