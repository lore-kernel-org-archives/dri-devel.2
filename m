Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789C4C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B0C10E550;
	Mon, 24 Aug 2026 11:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OYWLqoEG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QZqe4H45";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E80CB10E74D
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:31:02 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OBMRlK3406411
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=KBcF3v6N3cNbIQQxRfkuaUX8
 wTPsyQxH9smMZXqQRa0=; b=OYWLqoEGssz/m7iECFiWlIXeP5MbL9O/UejApR1w
 xkuHm5qt2yguK+ma5PwMbB5gQn2Na0/jsaMALOqEHLLSsuO3z3bQKPBYqVeFF+Nd
 Bva8oKE0xEH6isPQLEj/qY4deya/3kjz+zfvsisWN6D9TY4zwXotyefg+fZesCDN
 eD9Xhp4fEzOdAoqcVcbtMLSeMor0SEzkjTW5dpY6jO8Z2ENGkwu7x+58A2qnFBrX
 VL2Z1gJ5DOKUkPT8L7HmedI4LTJIDTATi8cmynVdeb+jYKD4TO/r0Wo8rGY1ZNWi
 XbNcX2dFtgYYZ9nxzOCOKluw29VW7DAskIGP96Zz1lQpBw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8jgk0s3x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:31:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so326310085a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 04:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787571061; x=1788175861;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KBcF3v6N3cNbIQQxRfkuaUX8wTPsyQxH9smMZXqQRa0=;
 b=QZqe4H45AWtuye1cukJ+19EPyLGOQoSHxvwPLsC0GgWkCrZMDG1y5vKJXR5HkSI0hA
 uiIGSbu2uR+tCyIxOMwSGyAzUCCtFjIG9+HhlSfUqz0AUB63d+iXd+JISHm2VhU0rKF0
 FA8K6hbr7jzgXCverotBUB/CTzI3FZ/aCpOewEpXbNXrC+bz9GDpEFIhzO0PEE1xUenX
 v+QPDRbqihgD3LtllgsR7KIBSfARCBgr8IY40TetCMlF4gg4yavoJL+dPXmtX/WlV8Hh
 GbvvRcgTdJJ7CvuyRCPbF4BF0Yyng2C4SA4AOzVGDR8qNc0tRIxcYu8lGNDr9dcvqTMT
 eW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787571061; x=1788175861;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KBcF3v6N3cNbIQQxRfkuaUX8wTPsyQxH9smMZXqQRa0=;
 b=XkFOBmyVBOGXqgU8V5mXHkVBobAiYwt7HHvpdrhDzU9fCC7/nvMk4wILuMCBcX2715
 eRpIxuTLL5gyO4JF2XU/b+YervHK9wZ3ZFUi+Yo9Wr3c+ZgwH8D0nsrTnQe81/XYvHAS
 cLWBnxCuVoEHSCk9aOGmdWcjEQzAWyVQbqMIrsXJ5aqadX8B9AiOgK53NVk9nh4+JEyC
 A+i28klyj2x4T+j4M5v/YB8wEjr92BihW983aU5AoZHUuPkOICbrOfIEkDmU0l3YACc8
 4BmLNcC3GHXWWiM87FdlILqRPZb2k3ro6Xv6RqKjinxS/NPaYVPiQVd+oky+yngOokXl
 OtPA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5bawy6n8jYstp1w/Fyyl5lonFL3ZmM+dbfBHDLFA5B5cmmfpCATkixRso8y8uq72h4XgEQQu3rPU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lq9p69H5iNrlZA0IhvxFC4BHEUm3MPKrhMNr/g+Sf+e1XWpwy1
 1qYaj3CWLW+yPeP/R3Blyu2xm4KLIQSZeXIMFjjiheExhiQ+WJSYfTwU6c4tUGK1H2OkaG0uxbC
 +vSSeu6OI4jGcAobjFf90w2U8iD/gSROGkZHJxFyvNBCNyUpoP2dl1+0ReELQQwB+psCC7II=
X-Gm-Gg: AR+sD10YM8ukxzBhU51dSHZvOfbSwXThsUe/34M7i4ExNlu+JL6EJMlyDlipxK5hTF0
 NgApEF0FhUrm5Brr1e9PULpAMK72ytIyw0BCHkcK76XxZQhXaJH76YqGmNwoiYI9iUug633GWka
 BXil4y81aMubayE5pxMHEt7H/tYDPDiYVouDVMrbGuEFmd0oClKBISrHKL3Vh/ketwdsUqFR7TB
 wRw9rYDD0At/Njnaq3g7y+iXYtEPAALAdxr7SOjdOjxd4THZi1FSciap5TQx+geYLGVq2k/MAMK
 scq9dLBTJaUOgldMO/bRcjbcvt+2LECcaoGjJTRbbw5iibWCimIWUhA4/5CxOAfffW+jzjs33Th
 m9WOXZ25kskZ2VGY=
X-Received: by 2002:a05:622a:258e:b0:52d:9c11:8937 with SMTP id
 d75a77b69052e-52df5a07b1cmr265826431cf.26.1787571061006; 
 Mon, 24 Aug 2026 04:31:01 -0700 (PDT)
X-Received: by 2002:a05:622a:258e:b0:52d:9c11:8937 with SMTP id
 d75a77b69052e-52df5a07b1cmr265825181cf.26.1787571060355; 
 Mon, 24 Aug 2026 04:31:00 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496738e7esm1342817666b.46.2026.08.24.04.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 04:30:59 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:30:56 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com,
 royalnet026@gmail.com, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, diederik@cknow-tech.com,
 alchark@flipper.net, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 09/13] pmdomain/rockchip: cycle optional power-domain
 resets on power-on
Message-ID: <ry7vprhcjccrjyujmmpf4jgzjblhm744yborbnldvamj35h3wg@auo3ajz55com>
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
 <213e3746a36f821798d3fd3e5d832d89dcf2ddff.1787568944.git.gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <213e3746a36f821798d3fd3e5d832d89dcf2ddff.1787568944.git.gahing@gahingwoo.com>
X-Proofpoint-ORIG-GUID: 94Sr9J_vvpXA7qJJDl1wV2bEhXO_aTTe
X-Proofpoint-GUID: 94Sr9J_vvpXA7qJJDl1wV2bEhXO_aTTe
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfXyQzuhMaSgAjh
 XWFlTrf8AAamWi/55hGo1vIqpPAvzISUYSyXij2J0Pllts2UPuBCZpEwfpt2TUn6+j80qm/zMZb
 0lgIiZ7wcuqGugqWUems7Tte8i14rvU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfXzm2K9bAaS+l2
 jwFAQaGwL9OJ8ikMnSqAZn+fdwhwiiUvPu5vqOoij2nOtfpltF471n9s8D0bc9h0SkBpr8gbUM8
 pyjI+zpH5rYR7W1tH1IwY4Jy5IHuSKAcy5IF2PsGVJ7oFjjjMJO9h97+tQ1mLLrri11XnVkzS9t
 MOe7Jf5VdFTyW3QwnkgdXBll261aHcUTpemUr/Wf7rQvovwh3AF0ck5yhCLhJQfRwJ/CGnJIxJ6
 +OAYSB3ZLHwOUPbtkwOqTmj/gPgkWpiCf2MW6OeQondxEHycqQxZ6XVSVwjJr5ssuZ/SpGw0GdI
 PMCZV7z6NPE03tHnrySE4xZnTgQJdwHIJSUPJxU2misPWpeYl3Qo7z9aAOABBvF2ojEvljmJKPr
 Ir5OsCjfEYnzzQCtUGy6/hq3QwqMrxUnzLTdY5937xaXVQV5zXCkvFn0b7ozk+96XlLW+N93/hs
 EkwEeXXOFy8N5TM93zA==
X-Authority-Analysis: v=2.4 cv=KcvidwYD c=1 sm=1 tr=0 ts=6a8c2b76 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=9GNsruGHAAAA:8 a=EUspDBNiAAAA:8 a=u6E1p9BJNrHIpMXxc0cA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=IoWCM6iH3mJn3m4BftBB:22 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240096
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

On 26-08-24 23:08:58, Jiaxing Hu wrote:
> Some Rockchip domains come out of power-on with their bus interface in
> an undefined state. On the RK3576 NPU this shows up as a hang on the
> first register access after the domain is switched on, and pulsing the
> domain's resets at this point clears it.
> 
> Take the domain node's resets if it has any, and pulse them between
> releasing idle and restoring QoS. The resets are optional, so domains
> that do not list any are unaffected.
> 
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
