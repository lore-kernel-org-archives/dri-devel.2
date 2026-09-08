Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC532C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B8C10E514;
	Tue,  8 Sep 2026 08:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mkOewvSR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IQ5jvqo4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FB2F10E05B
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 08:36:36 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886LkLZ3299414
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 08:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tiYasFIpEE/Y34RE614DnJmliaBqbzzu2btysmodjNw=; b=mkOewvSRFnOF0E3+
 qq1rNZ1Q8vtRFjpVAdEKQA6fxCJB8eOppF7CfUdX5QMnn2CpVw9/cO4UIaskeY+l
 18RnIebbn8MdK+tpCTnb08hweR4BIdJFBEUZOMJtKhsdbpHJBkj789oy5rKjXloX
 2I9q+tkyBUUhrCNDn8Wh1cDXrOqIqAq3nzqVVhGnK7RvVfspDErYcxf7+ImFFBC+
 HnY/gpv7kuV1PEF3P2UwaeeGTyuZnh90aNZ/j2nKEFlDWbLSX/m9TEdr0TbBL48f
 304e5L9qbQw8Ay89AedMSNdZnw8if4zX6KSen58i1UxfJZXIZMGOZWedKDZOaq1/
 wuUJRg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjb0p908u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 08:36:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93975d63ffcso483694485a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 01:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788856595; x=1789461395;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tiYasFIpEE/Y34RE614DnJmliaBqbzzu2btysmodjNw=;
 b=IQ5jvqo44yRwGiYCkS6+0Eks/KWcW8axjzFetymlDgeZCjcTvnQ961ieBgUlpGP48S
 XHQOIHBEoIXpmwrSNPiml3CJJl69Le5AIXpVjST0MMktJmUNkiejCDpb2ytbALl9Dzel
 ltgYY8agY6scO1+qRscY96ua6EwHpCu+XTEufErhqw4AYfJOqBeaiJE2OzvHDOiBV+an
 oZYw0dv7F20NSQGJGzbydjclyVt/Ros82stHP75MPzRvctarJfKjpS2PvT+iz1ky+iIr
 QR96tyxPoSuDB/0XgDUCTpgSI/JUw1um8miKZ+BPuKdYkLnnnrWI8qDPUKdOopaxmjqO
 sNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788856595; x=1789461395;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tiYasFIpEE/Y34RE614DnJmliaBqbzzu2btysmodjNw=;
 b=j4ddrvYp4kdW4yODzkI5oTbUHMuy4IP24M8gN5k2NUFbTtlnAYHgoRIYcqOtBjmlKG
 1A9eWCtkBP0nDZAhuS2JD7Qkw65OkSRMIWaanwmm4FBls4/vL2w8FtooP81f7/Ew59Ez
 nH9LuVtnjYMeq9fZXctxGydTfSlGk2RPega6fWaEgqimwjXihR2XUnrA1xN6u4AeO3BM
 MzWnXIaVWRqoT0cSZSYF7IohR2Zj6z8pvX5SWYP1VO3eNLhbeYRlfEi4gtWXiSrFSbvc
 LHx2plCAC9ut6tu+7fNmlKZdL8/1nZ99PI3Vcph8cbgDXFGbF/UR4/hLcvT3wa9soJi1
 nNWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIaET0ivV9MCb2FUnq84/HD7rDqMC0ktI1KN8qOhY0+GYcW8MipvDanXc9XRwJq4ZiRqQH7+YcIG8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++laI6aS+CNEk9jK8n8xERMVxk2pO2Bt3Znr20+LUGdaVepMnyCH
 bB0kia/CQ6+mRa3x5to03yk/i3VeRk5nb6AWhUEGr3g1i4S/QBzGcP5yMLQtnzOlNEbKt3PZ2aX
 Ap9WeC//dBuNG/6XxmsoVa846gsJWqDG4PAFeF+ySxhfeh66Z+LS/GWij0JKcj1cP2LbkQdM=
X-Gm-Gg: AYBFou25lPN4S1RQ9xbHgG5mbMH9FyJR0QliLZZ9yuogAA3pE1c6D6mljVWlrWgR1oA
 GObma6IxuO9In/IpcAvsgCheb/YcBzOPR7rqPmZMV8hEglUO3gtj+oA+hfQ2D1QpAJ3iKaOzS8O
 t2Hizs68NVQraopDSYVMyyuzoU0UQYU0XMrH9ZRHHy766i2lTMsqlrLrX8HvyBEITJJUk4SKdYp
 qU9lKM69Xk/b7AyXwgcwcGXCREQvu4rPE6r1V6ymN4/0vkd1KKaBzqPC8Mf5TWWaLZ3nlVrRg14
 40l3MQYCPbJJSFkny5PvhF483I8wJxS7zWY3DetSXmukff2GiWQOGyJDX3BFmICTqsgKJxIaTjd
 TjjZPaH5DxrPtAhsKjQItZ4fK2hTB
X-Received: by 2002:a05:620a:46a1:b0:939:922b:3de1 with SMTP id
 af79cd13be357-939922b4881mr2238182885a.44.1788856594826; 
 Tue, 08 Sep 2026 01:36:34 -0700 (PDT)
X-Received: by 2002:a05:620a:46a1:b0:939:922b:3de1 with SMTP id
 af79cd13be357-939922b4881mr2238180685a.44.1788856594450; 
 Tue, 08 Sep 2026 01:36:34 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6024a8sm482095385e9.6.2026.09.08.01.36.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 01:36:33 -0700 (PDT)
Message-ID: <0e876b5f-13cc-4fdb-b7b5-78621cfdd80d@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 10:36:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] dt-bindings: display/msm: hdmi: Correct name of
 disallowed supplies
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
 <20260908-drm-msm-hdmi-fixes-before-eliza-v3-7-dcf8956878ca@oss.qualcomm.com>
 <20260908072249.83C5B1F00A3A@smtp.kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260908072249.83C5B1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MEcT0AjDQz5-PWDWz3qRyHnG2jANLpA7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA5MCBTYWx0ZWRfX6eZqaagaAIBn
 m09m3I1OvKDvPU699k0pbUoSQ9q5I9gqaKfRBF0/089nFirhC5yjLXxwirXItYg35PUAfbXeizP
 9Mmwe8Mo36pgOigFicQV/f+qmMmc1s4=
X-Authority-Analysis: v=2.4 cv=HL3z0Itv c=1 sm=1 tr=0 ts=6a9fc913 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=12aO51z3czoBTLisYu4A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: MEcT0AjDQz5-PWDWz3qRyHnG2jANLpA7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA5MCBTYWx0ZWRfXw9zHsa70A6sU
 QhPBtkYiUHOHBhV7ApZ5hlKUNHX8Hsm3SajutkaPA/908xa0zNFuLCofiybkD3poy4OG9ciwC1/
 h3MKIQtL0UH2OSga/9XZGwYUPDgYzx7ic8nY3vuUQ2dIczZIvA7W09ujbKEhZDV82BjP0unYqSD
 k5oN9GyD+GcNVAcO+a1ae2UvTN6DDeLezp0+PVjy3Qe1hgiJw/YiCQCqfOwjeklBDrYhv1zAuPv
 MnetxBFHdxlKrXVGUWH4hV4Pu40IRYuj92gVQfWzZAhK0f//3qlqvH3H3zQW55JW0N2dpEfnNwF
 /rsRTtFF9i+LFrdolRgtWOc4l42qGeTp+27PqcTRlFiNzoAQEtnRMe6aYqTjF7qqz6o3aIzJfk7
 LAo6FAhpEI4Vpq8e8wHZmevLm/WF65sVNL2wX6VTOJPwuuEdJV5nFQHeMS2oi8xGV91xRPS0625
 nLyei6v8NGY0vSS8xhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080090
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

On 08/09/2026 09:22, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unclocked register access in `msm_hdmi_bridge_atomic_post_disable` if `atomic_pre_enable` fails, leading to a system crash.
> --

False positive

Best regards,
Krzysztof
