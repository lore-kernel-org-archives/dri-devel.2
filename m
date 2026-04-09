Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E8EF364B6
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 21:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE4A10E087;
	Thu,  9 Apr 2026 21:30:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LQsTYY9Y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dN3PZ6D3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD8D10E087
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 21:30:17 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639KRrUZ1729912
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 21:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yJUSlPXdrskJ2du69cuI9T1hyf/JLg2i3zoHSaY314E=; b=LQsTYY9YG1LiN2f6
 AcYXaYl40pc02NldjZy1HjUy84wgOVHriWiW1lPzmSIFiimB0ngLTW3mJYj3VvYX
 jtTc72gyhi/ljCR9XtIIjH9/XDqVIqS+yfa7lSgAWKpbthWfeo+YgiDFa5ftI/pN
 jKJKrZjSaaysm5bt53/sfHoLCQe8i4N9hee8XdkKERSxzXQFbrTi3mT+3lCTS8y2
 ZQKI9FZXSZ9E0+g1y9NexJEk/Vr+7hhlZQWNOQdTMowEIp66bQFBz+3wJwHouwE7
 U/BmcwEVg89X70bpDzoA2df1RQ2Ji/iIjbsJAAuvaQdPTtZTHj2lDjMlb/TujzB7
 7W+YnA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deckxhqyx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 21:30:16 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2d443c3b094so1889170eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 14:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775770216; x=1776375016;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yJUSlPXdrskJ2du69cuI9T1hyf/JLg2i3zoHSaY314E=;
 b=dN3PZ6D3jX/4JgGdh88I7M1MJPJYZZsHw0mJoB4H+HXqKUi02Hc12xZdmZBwHVXUQr
 O1ERXYkvfCYmtSRP5UznLq8qB8uzMydwwbrXpQBXjq6FBs4Ki0gF0BQlC+KL2+Bf06N7
 Aqbp1jq8AwG/0fEaT767SZamePb3qIMk6LasutEJTvVFASfrKJQrIOPNxf3p8IpFNaCq
 uZIKAKKySF3PHTABsb42EJ02x7rmLQOgSsh2KC3xlTko9VH/sVwnoLL1kGNFlG1M9aBo
 II5Nzd2GFIOiuLvGrKlmiZB03FXYbrzgBSUegsDMFlN9mnlOkTxpqIUINTeIxlTJ05SY
 kZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775770216; x=1776375016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yJUSlPXdrskJ2du69cuI9T1hyf/JLg2i3zoHSaY314E=;
 b=m6h1XWQm9hZuS4gYoXd5fG+Oll+6TXJ8oza1P12pbBDpYFu//MPmviagrBi1kVcSJK
 DmdGflf91jRnxghNUUNzeXOLJHsYUrCxtliveL6G1q2ztvwZTC4PHlUxBZLbDl3dr39K
 BjFH/k+hZp4hRZRyUvNOe6fx32flWW3BIH/WEPnSI+V0jQTseLoZ0d8AtPVS8d9kWddz
 sGaEv7ZfroDibHXxoGHq3ZbpWX0IMummmRUoaqyn4RTBstm8aB40co+H+8rjctsiUsmZ
 k1wzW00qb2MmxbBCLD215z9SYmbJgoNIs9CyK0SoRRforqV5cb3W++YqAyvqxO6bZKt7
 4o7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgjfGfWeYSXKlyF1THjFsI6+vSvojtfobY1Gm6xkaCMW4fGlGNS3buojmDwwbPdQDXoLH8Yfdfi6w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYrtJOi23fbthkKpL9QzQpzeEHbdpfaFH8/3x1jxpx8zAvgYCC
 XPpxZc3F23CdPyxZRxZB3pdQtMWkvxRDiorr4XnXZbSpAvhQ42yv+3EjqTGcJYhx9HE9Nhp3Ozj
 hUfSXwPiSzbqHtn6VJo9YQnskv7ah0yjKkSJc7d+CgCiONdrPDjeTQiFtrvJ0Dtg4ZnRkaYbrdo
 VXm3M=
X-Gm-Gg: AeBDiev5LcXrX+TafZe5crxvgQre5V6nTw6ekcQvTw3/4A/orcMCxUN8H0aGsTfKlwN
 RhKhPpe914dDvAvZM9HD3yLWse+KICHreWrKQXXs/fkUDuzE0MJB+MXxll3/Yfg0pe5fqVn6c6g
 TaxvM4K0Lj56nL8uDg2JHqNY5lVxpwMWrLk6WJjadAucPh92xFUj9sPqBF1W2z/H3d/Si2NRrnz
 Ym4k/MDpOTeJltVJ7TLnKYhPDm3XLsjXMLiVpu8N1w7nv6afByJm4qpeaGXsdZpVwUK+1/gZTcC
 PLr7oVGp1xQ1fYLvUYZFUpgLCxTSJC4NmmQSIuxq7oBEw7fjrWyje56VoTbpuPxO3B0b9fg7p5j
 6K5x7cUdImXpMQEeXoRxsUs8ZVn0ZCNtdFhi+IcUYTMTdnNDB3qDdpT5+y/YhlFK8qkGahxQe+U
 Y=
X-Received: by 2002:a05:7300:2156:b0:2d1:d434:d022 with SMTP id
 5a478bee46e88-2d5832e2f63mr507978eec.0.1775770215630; 
 Thu, 09 Apr 2026 14:30:15 -0700 (PDT)
X-Received: by 2002:a05:7300:2156:b0:2d1:d434:d022 with SMTP id
 5a478bee46e88-2d5832e2f63mr507940eec.0.1775770215088; 
 Thu, 09 Apr 2026 14:30:15 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d562db64c4sm1357061eec.27.2026.04.09.14.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 14:30:14 -0700 (PDT)
Message-ID: <4bc1363d-5785-4214-8057-4f2a75e0f8a8@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 15:30:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] Documentation: ABI: Add sysfs ABI documentation
 for DDR training data
To: Kishore Batta <kishore.batta@oss.qualcomm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-9-47ad79308762@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260319-sahara_protocol_new_v2-v4-9-47ad79308762@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: c-whbNILt-DiqLxD0LyvRMI5fFSkgrzP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE5OCBTYWx0ZWRfX2YKllV3Nw3dh
 /XJr1cUAu+6PFgeKYoOBZvNMoOo1A6VLTl6L55l46ty3B/IEBghWBdoQn0nlerpVDa/AGSk+obA
 Zkp+2obmPb5J78ZtZCMUGe79cmzgegUvdu03N/96RgYMf/rN3+0wUg9f8ej2171zuSwqnrC7JfL
 +Q950c+uzyPqXaJBUYMpcoPk2ZargSQnYlGSJPexKfpFJCpw1b7SI7LSWjZvufZ5eO4vnURRoKF
 qDh//0g4bS4m4Icf+k1hGOZsVBH47Jia1Vcnri4NbE18yyZVdG5Xn20wgC9saA15VTq+HCZrHcM
 nmkepNe0Ltz17wxqdm8RNpWvviZLNPPT+eqULMsj4mzBsGMmiwKiyrrrohwQZBU96lZudnWgbbl
 GXXaU/xh+BhMP1xKDHTBmFzZoxgPCcMDWoMSeSrwf8nCn4Cham51UhnhHtWb4mxhETk9ZWd69wI
 6BXMNAyTx3yIQYYtLyA==
X-Authority-Analysis: v=2.4 cv=OMcXGyaB c=1 sm=1 tr=0 ts=69d81a68 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=DdBerv_ObsJuwx9ejj8A:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: c-whbNILt-DiqLxD0LyvRMI5fFSkgrzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090198
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
> Add ABI documentation for the DDR training data sysfs attribute exposed by
> the sahara MHI driver.

Sahara

Also, this patch should be squashed with the previous patch since that 
is the one that adds this sysfs entry.
