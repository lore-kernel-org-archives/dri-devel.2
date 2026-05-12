Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED977CD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 16:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52BCB10E295;
	Tue, 12 May 2026 16:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C6lhApsU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MFTUCb/D";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56FFA10E2AD
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:21:26 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CDgXBg680346
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EFl7j0YKunj2Vbw126li5xqaN5v5D/S65Q3oNJTH0o4=; b=C6lhApsUTArwqNAV
 x0Cuo7+aRf5TO78dnjCnLGJDdF/4BAKGX+8/dlcyWrumNGQgJW5caJN9jmzS+oSk
 rxLRQzgDVNMVAp6292QK3rbL8CvE/5YKCk6cCYCa6vCsNnBt9vSLQy2Piv813FPK
 ErG7G5O6CzkC6yVJIRl5bQpOyJua+EQnnGEp4Gs2DI7F4Iw1HToCQ7QHN10hoFpP
 FQShhatWaE37ozMBWDP7ubUJwum7yn3CLKSgok2txbBgnhlseN/zKBAXmsWTpkDj
 FIARs9stoletv4+cy3Fc4w/uSsZZxs7jy/2+v6IV0wU5BF0ksO1AqpdMWA8V2DjA
 5ibRAA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e45avgn5m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:21:25 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12dc1c0b7ccso6173022c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778602884; x=1779207684;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EFl7j0YKunj2Vbw126li5xqaN5v5D/S65Q3oNJTH0o4=;
 b=MFTUCb/D7iUPy9XbcuiWWeFhpiN4f6Uld+2fsF5DVZMas+TmzRb1PDPKjhS6Bc0tv6
 FD9YqAyQ8OuULvQAFzMaCMMEq5KJs9ETDzxQ1uyWW7SuHRS4NjWC480XSIPd00Zm1HXV
 UhzJBIbOSCxO+3kduAAy6MPh6OIavcdb68CD5fzdZD1dQLWT08TE4wwEZk3Zprra/kXK
 yBXMnEdazTUkWPop2AicHqEh/tDx1h3tMIZw9hmE8LGW3bZUlySTdc7bCYCuTWVAMinK
 74ZT4fKNu3Vzsw66yL1RTAnej0mGjL9tApeVDXB/zALGdN6coWd0zWV9RzZkUL9MxJ8q
 bVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778602884; x=1779207684;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EFl7j0YKunj2Vbw126li5xqaN5v5D/S65Q3oNJTH0o4=;
 b=DWTuazrpx2yRCWS8jfpUy0uFfAlBUbk3Wlmed/4bbPUB4oilAkI6Ekh92Fsm4W1QIG
 zFSADr2WiY2X1a9daoZBotNXSpcyfNPoeur3/4uRkh+r1pgJod5VwWe2/DNrfVxrZdl4
 KzzqTfGt+hQHR0/rdhEmkhJwP3YlKAiap+4lXfVknIhST/C0HH/fBtABtfvWipCIk97L
 KAc6iFOAyWIKdsbdCTFr2Dk/jk8h1lyAJrP50hsicAmHCCOIFNO8H9oZb0eM64BJrLp0
 qo61oAVxhao542BjlyYSoBiglWTw7fReLf/5cACwQk7zgAtPEXOryzqPZ0PYSx0tZEV9
 lgzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zRESvIcw/u/94YQ9isqgfAj/jVqT4l8i1yendtGsq2HVKX6sVPBZnp2729+7wD4TiRzMxQFDVKFM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwteBEot71AEUHAe0Bu68mVStWCF6y64hcn00eEuElN5nMFYD2/
 Q1z3hLV2ootatBJxAScklGe5rdipdEjkFjewySS/STUxWXK5qRYD3XCi0NYvz6o37NcWkrPpCrd
 fJ+uR/21yEO4F9V1z/p2bDrLZ5vrBl5TCFYHbu/lXwwYY/Bl6de9nkZV2KorHk6U81u9l4LU=
X-Gm-Gg: Acq92OGnJw8Du2GgGUvwdWMA1UBUW3igBSfnYAkGQ5km1k0CLlK8Lb2BXPT9Or6WDj6
 jTnzMuCxBeOJq+roFpUWYsiiPrwYkJi7mBNS4NFDdlS050vWNr0ouSq/TX9Rqq438ih30bSfymM
 vtIkhpgiq5jdzRPF13o0PDIgQjwOKDy8QSPspCH4Yvejt5fAi665Vm7/2ndlFAXh4x1AZ0Wm7cc
 p3+tDt+4UPCOfRlQiNcQzeWSpvUD5bqGw1dB8hECdnb4mtGeotY4XQ/tHfIuFvGsec56ai/2j64
 8ANVo3cY/SfUeGSKlRNuZrI3oK8CC5JYxU/ksWHr7DF/HXk8qI3vAHP8FLPcNAU2Mj1qxpadq7f
 v7ILYBMCEKDxNOKVQV4iF5V0WXCZPB679f6ubllUPJh+4+viYzhqrVGDsJSo1Yy3ei2zBj1LD9X
 g=
X-Received: by 2002:a05:7022:458f:b0:12a:6abf:ab1c with SMTP id
 a92af1059eb24-1333b1b9466mr2440518c88.11.1778602884434; 
 Tue, 12 May 2026 09:21:24 -0700 (PDT)
X-Received: by 2002:a05:7022:458f:b0:12a:6abf:ab1c with SMTP id
 a92af1059eb24-1333b1b9466mr2440476c88.11.1778602883547; 
 Tue, 12 May 2026 09:21:23 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132781103e7sm23886722c88.1.2026.05.12.09.21.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 09:21:23 -0700 (PDT)
Message-ID: <8f2eb932-f70b-40d1-a5f8-6430fc735f71@oss.qualcomm.com>
Date: Tue, 12 May 2026 10:21:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] accel/qaic: kcalloc + kzalloc to kzalloc
To: Rosen Penev <rosenp@gmail.com>, linux-arm-msm@vger.kernel.org
Cc: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "open list:QUALCOMM CLOUD AI (QAIC) DRIVER"
 <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260401220643.12802-1-rosenp@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260401220643.12802-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MGDk7DejwrhQ84rPbEjfgToTGoL9UdqU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE3MCBTYWx0ZWRfX1kUNV5EYR3w4
 0bQncSRR0KbaJZX0zP1rBq8KZqtOiRJGTgtFDm84w83Wu/nUvEcW5Bq8fobpHZmJzKeR+WIyJ83
 5WRqNADDtZiip/nKWuooo5lShLNQMuNrx4HTQNhN0vjpZjV+9LdMp7WNjYDu7XEmYHIidPkBqJ4
 RaSBznabw6fOyAyYj68EL08qIxO4y4Z72y7WhhQXJaQAB4sssQo4gfATShti0IDaFMVjLLDgwuj
 wtaiz13bYas/OaRGkSPtau3GPvxlt1hRyFYrHSvN1U28cUWJW9WuYwSoc0G+Dkc7VB5OJd2czL0
 Wp/o4HGYNOzB2KshqLcR7GCPcD1CghrhDv0hiGZWW6YQM9rLGJq7xCzhg+jiOqtn5NiUJwks/Pz
 oORU7k089RYaN1AwFCGX8+y+hOkAjomoBcGuyO5OVd7q1erEqe1dWKtDi/9zqFKz67+40xmXE5a
 nCA6bHYHQgMkSA4VrEA==
X-Authority-Analysis: v=2.4 cv=bOwm5v+Z c=1 sm=1 tr=0 ts=6a035385 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=1lcS69py3Ix-9TsBHUMA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: MGDk7DejwrhQ84rPbEjfgToTGoL9UdqU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120170
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

On 4/1/2026 4:06 PM, Rosen Penev wrote:
> Consolidate the two-element allocation into a single allocation using a
> flexible array member. This reduces memory fragmentation and simplifies
> the error path by eliminating the need to check for allocation failure
> between the two allocations.
> 
> Add __counted_by for runtime bounds checking.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied to drm-misc-next

-Jeff
