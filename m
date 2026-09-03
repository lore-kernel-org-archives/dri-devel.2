Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CCDC624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 06:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E107D10E092;
	Thu,  3 Sep 2026 06:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ms4Zn4Ra";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="csYbJmic";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9908E10E092
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 06:33:45 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6835lcqZ3641942
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 06:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Fr7cHeYqrI16WQmSdQLJQaBM+npOKUH7CWYOJaeU504=; b=Ms4Zn4RammyQ2I/u
 iWL69q5E75UFIB/stRmu22d6yz5BXjR7sPqxcxIGDfcLyW6Dj6XxTA1xx9ASb48G
 2k1vZluop5rQ5kZfWOBH1wFOdazLf+bv1gm4DJisowPetpYvghJ6XYC+ko0cZEZ9
 3yZ8a1n0fQJzQOSXf3GA+YKDHrOqJQnb5UBVa361ilEqIQOtzr9+9fGLpKXDREOZ
 ksMT9IWYnqWX2yIn9Zm/tWpAE8Se32/ZyqjhDZKY0gL9VtIiVNIaFBXVk5Qkxz/v
 7P5DI4kITzm4qIfWObd+vKv/dXOYAPAzQ5z3QSCTTRoUVNNlTQPN1GnVlN2vi8Pk
 3fP5/A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdug2t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 06:33:44 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5e21552dso26890585a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 23:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788417224; x=1789022024;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Fr7cHeYqrI16WQmSdQLJQaBM+npOKUH7CWYOJaeU504=;
 b=csYbJmicbzJSdGlfcNxiyrTZr3FLJ6pVzjxZmSCK98E8EWTrHtV1avB60Z1pkTPCux
 xMplMowZqwaUOLdk/t8resOl6Pm3MYjKwX6jXvzEM2ybsAWF6thitUQrXzAAwFGQXiUJ
 gHdQWljXjBaYpFUjyJk2nLZ/YkrA+TMQ18PeOMXXv1ITKrlvBjgq6X1/04vYQVLVPOcv
 s/e5gHUL/MkoqpFJlvgTmBH2Rp65fBddWtrt9tHGNmX4RPhy0dk0g9gDBT33+B0ybfQA
 kUWzX8bCgnf3aM5pq9T4LXkdSr6F4Cr3EcVMFAv8UuhuDte+eEFKK+HgV9bzCorWBwLO
 4n1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788417224; x=1789022024;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fr7cHeYqrI16WQmSdQLJQaBM+npOKUH7CWYOJaeU504=;
 b=aFZ6/W8KgDe/MJvsRFn7BcSKGKEDBNCQ3zfKiHCaiE1gDEZA9d7GKVqF9FSkM2DoBP
 coEc+CJOHs2hBNaeTHuULGIJjtDukCE3ZAJqhJDp/GpH3NzL6gzCxoritRbgw/tniUbi
 qgdqDmp0oX7ovmZykJ/6hrXpMi8PKoxqpEoZ+IHf2XGwo79bJJYjRXHiy9qaPwAKWftG
 J/bmKNnV1rnUo9FYMMIos7i6jXjOUX5R+I1h+v3gboHyvxiZ+Df3UJ6eclkc5sn3iEK7
 rfrvSX6R6tbHNb3s1QPvIU2hELmJrfZTwBMYXJeXXR3GlAxpuMcvAcY5pKl58jgGiWT7
 WQpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTgIkZbHsB9UGTugNjA4zpe9000b2IV+IOn0cY7I6MWjCWs+OTSNhERcxe+uxgNG0C3MYyKx4gUK4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n99mkFcN57TID4O/rHIUU4UPqGAa3zfMljbWfFfZsfHBta+YeJ
 aPe1TJiZmUtPx35AAXyVQ1rm82OSluVgE41stDTunb08GHmsT5kwuNT13wsgR+CGWlIW32bc1p1
 RdyD7DljUmVZ2NHbbujvkkwb5so9YhY8rH5S9xMhpGBu3W1wMV/ri00RF5RywWzOh7hxSGFE=
X-Gm-Gg: AYBFou0vkkaVU/GGp1Ijt9zWw6gmOrXzIOAD+a4NNX3Mm8lDAPM9rbRY7Ija7WgnTbj
 bgZ8RG7WOCC7mTJQySeZGHSj0f0/lXOSUy6bBurkArzT2VrqTVCcVA8u6+S4hcwcmUmpalaUDpF
 0VMrlzCVEoJtqWv/W0lLm+trC7ngAXwl2wZDFX9Mdh3IBM1lndpr8ELo9Yje1Z7P9mdsjAPyoiv
 dhLAN/3tMHtsfkXAs7QlfMuzUDBDDM3wKuP8t1nBTCbJYYEfOBcPqo9Gc+kuOtFJ+QA1v4Vclmx
 NFFs3lxBosBckAhUA33p6p0ct5RyDtlTehH51SQ/t4I6KGVWn9dtKE9X4Q5Mba+uQCGMKMZVxq4
 oOXVPNIcbPT13VAYovAUP0w==
X-Received: by 2002:a05:620a:2704:b0:939:288a:8a0c with SMTP id
 af79cd13be357-939610b5598mr702104785a.6.1788417223822; 
 Wed, 02 Sep 2026 23:33:43 -0700 (PDT)
X-Received: by 2002:a05:620a:2704:b0:939:288a:8a0c with SMTP id
 af79cd13be357-939610b5598mr702102885a.6.1788417223371; 
 Wed, 02 Sep 2026 23:33:43 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25f3eeb888sm53439266b.9.2026.09.02.23.33.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 23:33:42 -0700 (PDT)
Message-ID: <292a6a67-0870-4735-a34c-50f2cbae36c0@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 08:33:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: fastrpc: Use devm_of_reserved_mem_device_init()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260902194041.1999834-1-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260902194041.1999834-1-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a9914c8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=OkyngIYZ1pMGiDKQ6L4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: ersMQIaU3h4WJyQxsFsVziFbNG5AsuDf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfX7jd1mGNS0l1x
 AcogGfr7uG6rRVefALgnmUY1c4Op+3gkjnC19rNAXT8YhcxpFwWkK1Ttx6eQr9EjhzWZ0K5HHlV
 qgI5sHfQjDoWMOV4Y540Dj7ivCy+SQ2NIUo0f/cj+lkmEh15IWQ3jj+7IjPwFEK1/s1sMl7OiHA
 l7aAWF1Kt4siiPK6vEtDbtu8l2hewQ32k+TOZeXi5idrKQobydLZIF/Bj4xOey5Ae5j5hJjdRAW
 BSo4+b+XKg+64YPDaIPCDS0e4ENSyhpSQa4Y1IT6tzEL/sBHeY05YBdWJh8QFUrePwcStRVEnC6
 50MLfeWmC08l65Hz1Ae4r4xR11+XRov+lpRAYgMzne562j4sznF2rZEsPvdGS2tnJ6CLAQ601V+
 Gl3eAhYBLAx1dAtkRPvW2tmaqAobfBZXWza5dLRiOwYiN2BoR2iBHqHXooBcM/G58q8odv3FsUB
 7UdjgiYlCxTSWSTP1eQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfX0MOfEeQLbW0s
 pyUXbMe0ND92anRbTyMHWxHTMJpLN6hUUHRVSg6rW2MOQLs/VRICY1pYwrJI5FBJ4BFGW82P+ZZ
 Iy27POQ6EIruLXKQU/+dLge3I2Q8Z78=
X-Proofpoint-ORIG-GUID: ersMQIaU3h4WJyQxsFsVziFbNG5AsuDf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030057
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

On 9/2/26 9:40 PM, Mukesh Ojha wrote:
> Use the devres-managed devm_of_reserved_mem_device_init() to ensure
> the reserved memory region is released on device removal, fixing a
> missing of_reserved_mem_device_release() in fastrpc_rpmsg_remove().
> 
> Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
