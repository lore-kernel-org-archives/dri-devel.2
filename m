Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C049D606A885
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mivVSyox;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V6GxjgLh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CFCE10EC29;
	Fri, 13 Nov 2026 17:41:33 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07DEE10EC29
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:41:22 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFR5D9551894
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uIeY3cSe4codMyJtw4tcntFc9/W1d8epw+OkHuY4l/Y=; b=mivVSyoxeM/tvaji
 OETnsBbiUeXU5EB/w07Pxz0/ScxvRAkCPHCvCg8f3+JaAQboKxaG+9Azc2eJTKkn
 aU7iYvhxchXieSbC/reSIt4dq4sqy2KjbbNr7n9XepTL+rmiGAYjFi5Es1vTPeXY
 lOFuPM/bYTv0qT443rcY0NfkEcI/k16EK8Kkrbb4RH1Dv/SXPXQRnc45DBPro4ih
 sOK2s1r2xaNbyGIGsfk9GHWNhjNDL7qiQNR7rnUOL8xBjxxdAVuTkVHzaETv87il
 Jmpgjo1k2IOMxL7GalvAJhmgJIMlgRYmVWn5TZ8a+uMrPafvcStNLD1xP7FsX8TZ
 DWBKJw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwc374-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:41:21 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36de26cb4b3so1516738eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794591681; x=1795196481;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uIeY3cSe4codMyJtw4tcntFc9/W1d8epw+OkHuY4l/Y=;
 b=V6GxjgLh7WpgE1cEaxSWzEbakbTECjkIBx3ixImhT1Ea/xgOLVGIxkB29XnXT6oXFA
 vfWRRc/acikAdR092Bsm+j/T8RerAeXha1EgYKkVyOn4ia0MukY+Q/OSuaRVT1P6zved
 H9s7kwdG/uC3s8sify125/TdTzbV/6lJGwI8Eb6636YVO8FiocG4/C8zVMqYQfNQpL4T
 CPgX1twxXKwI8hj5yUkijRwNL8Phbdf+WIy0gPRYDGoyMIKW2/nwWRU4X2hmkYqQdmwx
 r8mPQ37COjA6QCz/kpa8pJqaD4tk32A4XS1q7XWycxPnP4TjUHBG7Yr56V9H/f817u76
 cwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794591681; x=1795196481;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uIeY3cSe4codMyJtw4tcntFc9/W1d8epw+OkHuY4l/Y=;
 b=JEBv4yggh4qwKRhEo3TevuTdPRf5DJIB9yjJBwDV9LwE3r70IjeePYtLuAmOH9TGIB
 1FmnvwfmWEm9eKH7rvLTyT8ElQukfZR6B6e8rdk0IOZWSE3jY3xuaXEvHd8YCK8QPdfv
 LUKpZgnMv4Fqr6ZuYfyk7OfMagIBfFFkG6Zn5HHbzvVx1hmsjmjrKYg4Rgnx964cULE6
 1R/lfGywcUZT73IN816CU3KOlTbheEI8c/sdHrXL6Y2zTIlFrPBtpctFMfJL0RgQYJ7L
 ffPSupGmZSlUGb3pTq6mAgczaKcxIZmAgp9fpVdJ+5M0fw2TQb7hkm4PeJfzjsJ/2jQo
 wUWw==
X-Forwarded-Encrypted: i=1;
 AL+hErFXhG8NQgkq7dE7H5QwjsEZ9yKlTj6s1AnIZDpn3CN4JSxUYAHH/UqGUAUCXiLDGkDDTOvAzgRMNYM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+mdssF85HvGTLDYjcPqc8XLMR0Fx91tQusH4uVSriiuJ7rLZWh
 aMGE6yduFm7fWVtoBjvx7XvuLO4cdoH/pjh5oAvNUY/75YT9XBJGgizTz9+lEOAa9mbSJUeNFyX
 HxG6iI606oi72aexuoEvkBOuHLU2uknR6tyAI5iuU0OECKURwjEkPd7qUHrUeOzkrF5QBbYU=
X-Gm-Gg: AYBFou3Xv+fKGaBkWlEmY6g1tjRx9eTbyPXpJ7aaEls5Etwap22rjxHfQSI5+utsuNZ
 PsPKFLYoLP0kpxGS6Josc5pYs/OSlEyOWmrQ2aq4lCW7uUZZVkVsGS41BVKWv08VzW9yO+bhAbc
 kW7L204IBlBHQ7A6QwaPEjxEbagdHZCn03NnRyIoT8mDW2mQSHbEqnF3Ne4zBQ6OILVbr/6jYX8
 rhedZkSD2/X++AcyEhHqyGWWnXcY9jaHAItpe9V/piDcnyzQ2MgjeP8RWgokFCBmatdjtRCIHB7
 VPlaK1Z460fVQYX51hIDKC0N7GEBp+I6yf+X0Tb0wDj0CI4Z28tHO0vtAWjLdJ7EiTIaT5mUqBy
 He9dQpL5V+lXldyLEk7PyxaH4jLailgbnlc5rGte4Ovaj7atCsv+hDdrUkVrZuyPbepOsQKq4Cu
 WBpFg41SVR/GR1BA0mDtiRJ+M=
X-Received: by 2002:a05:7022:5e08:b0:1a7:99b9:2eb9 with SMTP id
 a92af1059eb24-1b503115942mr2694507c88.27.1794591680939; 
 Fri, 13 Nov 2026 09:41:20 -0800 (PST)
X-Received: by 2002:a05:7022:5e08:b0:1a7:99b9:2eb9 with SMTP id
 a92af1059eb24-1b503115942mr2694472c88.27.1794591680368; 
 Fri, 13 Nov 2026 09:41:20 -0800 (PST)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50319d40asm8020312c88.11.2026.11.13.09.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 09:41:19 -0800 (PST)
Message-ID: <29f8645e-8360-4463-a809-da6faccd2f6f@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 10:41:19 -0700
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
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af74bc1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_a0-uAXI4ZKTf_5tdocA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 4RhPpKJBuYRziO7EV-tNAjjDA0ucp2Nh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX++er8DE/IkpX
 yfy4CBF75ejqsporBXmJQJVwK5gDNgfQe/J2riBJrlAJ7Q330oiiLnqjuuZF0MbWr0wgtwOWDSP
 rrksBcPzJMANFY4C3TDJ5jT1qpSZk23kZSuJhWzg61w1iAbLbZ1dTES9C8F/ltubeOBI5Od2DVl
 WTnVgJ9ffIIh7dGJOFIrs4Ek2hrTyXBze1SJx9LtDWgmR2fsu3P5wntzh/flVp6J4mcGJ50wgzF
 WmvP7PhdChXZ0v7TnH9K2WvUQZPZmO8WfGv8lIm5PR8EXZ8KvoviTAxim28GLBAWyEVm48KI5vJ
 9u4yiGGRPt6S5HCbZYIYBqEwP/4YbyEvb1jAaLitMLcGVDr2ec35x2b1fz9Jbb9K++uAhKGkJO2
 Q5vSqh3Vhm4N+E0PlUUSgbEQPsw2SlRkAtZJY2nOaFE6b7P/cDHr1d1t/gvUSmOP9RC7TEfNSz0
 eCwQ0sKuaACYrqzDUdA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX3BebiS6EAJk6
 Co8jm/VunF4uNGQKBfD+5U/3TucUFV8e71c8E6gewio+NvfGBMsAACPU5P/9fz3svFvV7F5Dlc4
 GSkho9NZJGu9EZSEr/wIqA/pJYcgvmc=
X-Proofpoint-GUID: 4RhPpKJBuYRziO7EV-tNAjjDA0ucp2Nh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
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
Applied to drm-misc-fixes.

-Jeff
