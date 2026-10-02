Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C00FCA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 23:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58CA710E045;
	Fri,  2 Oct 2026 23:45:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yh290ElD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lda2KohY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B1ED10E045
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 23:45:36 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NeVRM1956799
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 23:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=YgTkQRn9Jl78hxcy8EjhxfN7
 hIYcFJc0FMzXtgfR1Ok=; b=Yh290ElDF1DpR2zJdaxME98AIGCHkl+uInh5Unad
 Wg3ed2JCCKBa4K+wRgy8+tAlMB0+S9XFExsGJqiM+PdhZmUeEMkWD0LeSrbm/GRt
 OA9ru21SavhVJOTkzLJeNFixju1+31I1s0rj5QLkRngjLDJWRdvjY0+V6FUYMGRT
 9XpBDrgCRoQSl75CaegdDQ9BspGdjXTMawqDY+bWHotSwIa9ol6vB1nIs2HP/BYu
 ae3Pp3yBatvjS2AgQMGaU4KDMbai889dSZtiZyvLMGl+sT2uENOgtmkFlHq4ZlID
 GCfWllYQdutKDU6R2Hg79+Grs/MPC/2Hx1/WotvxH6uvmA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2j0ks0bh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 23:45:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so20681585a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 16:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790984733; x=1791589533;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YgTkQRn9Jl78hxcy8EjhxfN7hIYcFJc0FMzXtgfR1Ok=;
 b=Lda2KohYZx+ncvcQNZcFuDbc+p9hRXLxx8Th76pEtxe7ZLGOOOMXJAV2d+NSoQnICz
 qarz79Nb9ZSnx2oS7TWOU2QuT4F6OchEhvLmaPZxlVCuHeeveiGs8HDuJTzFhbS/wvs/
 I25SO2mPhN3ukQsqiJsLfW2kzdmKVdhBhvFngXpPNYogZjBzdugOZUuNnj4ej7stY6wm
 A0z2j/FFnMA9FZfP8sHbYdjM2X0g58v0S+fuRUBLFAgMmvGSGh0iyL4MJVe+tw/28F3v
 5RD/FcPtRgZljfgjVV6f56kCgSeR0ysWpsDwC75NEAlUYQSCTR8lNf+kb0BHnZvWB8vb
 rTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790984733; x=1791589533;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YgTkQRn9Jl78hxcy8EjhxfN7hIYcFJc0FMzXtgfR1Ok=;
 b=wHUqXZbegebXuZE0kRQwVAYFxZm+e/EzEkoLiSxZfCfre35A9lqulBVuokrIl0e/ne
 2fuUf28GwZo5jzKcPcZPU7JE75h7xP7XY43xccfPDAYX1hvvXWz82o1JPhOh6R3D6gWz
 z8qPdPTa2tpCsq1SwNFlEMf3Fn3TZX3C8LPxa/uDZQh4ZejWWdVpBn5AfrP3NSoAQh1A
 rEwWCt5ntIOw0HkKplBaxpwUfvuUQheKjVl/5zao2/3H7OiML7/SGH3KCilqgAWQG9NM
 97RpB/dbqF8daNYmsX6mMx8BEUtZul3QGWQOiQFZSTExTnE5xJ+fOXW+6DSuQbjRqx2p
 knog==
X-Forwarded-Encrypted: i=1;
 AKwUvByijyvyirXL3vVRoYp4P4ImvlQHMdv4m2/DGMBqKQzjtqVMAq8YlAAeYs32Za23z1jB6mm/LhqCj5U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mGtZ5gUpqH61gsjLbKLq19rT8UBt9eBA7PYHY1EPyB4nhp4PMn
 hcAdSdRCzNInOfYwTC1C6/qSqiqSF18dPr0eOWbb2g1oooRaq/LAQOMZNCetFwR6Xfm4f6F9uFs
 xsAsviyzCUmA5foasRUTPoW8FEYh4Xhnst3+HiUpV8Sp91oNk5z4dLG41C/1Edo5j/z6LWao=
X-Gm-Gg: AYBFou0lxRZoJOjzEoPFObJpcrrQMdsN2HkdiqAxisBthpx7wmm4bohkbk2UNdgPz2Q
 hGgPPwe52238qDDUSAw6otbqtqojRcEx1OnP9DBv26efIxL2afyKVaXC6a/WXUbiKCt56MHoDbi
 rWYQwrLJnm9Q3qDS09ZxAWZ0SJox5ijFB8PvczORGZByCW2wOSv03d3JMnRpiJelq5vGjwbSR5L
 3qnbBhkfyn6/X6y24GkhDmhlibPaaayjTxs61taYdkLLwfR931dPJ6Rmwf36tX3Tr41ng+dK/pZ
 TV0KSug/Gq5lwikq+ZLPrwqIehYB3fU+Me00P4InYZamgrEMM0L2Mcb5Ie/3K7e1d6ks5eHky69
 L7dQVB5G4hMO7O6g2CWjCz8+X52VsaCX1C47wAjgujDhnLBy0obhtc5PpCqUF2OzSO1lZQxROPh
 csYGtIh9rGAhaR
X-Received: by 2002:a05:620a:a0db:10b0:93c:c6d0:1969 with SMTP id
 af79cd13be357-93cf170b7e1mr616285985a.15.1790984733186; 
 Fri, 02 Oct 2026 16:45:33 -0700 (PDT)
X-Received: by 2002:a05:620a:a0db:10b0:93c:c6d0:1969 with SMTP id
 af79cd13be357-93cf170b7e1mr616283185a.15.1790984732607; 
 Fri, 02 Oct 2026 16:45:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c7959bcsm1119191e87.35.2026.10.02.16.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 16:45:31 -0700 (PDT)
Date: Sat, 3 Oct 2026 02:45:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Oleg Keri <okerixx@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: don't report link training success after a
 reinit
Message-ID: <vjjdhsbkjxomgzeirl4n6qyvyz3wu7xaoyie3vakada4r73hxj@gicg3pz2wjuz>
References: <20260925125314.16563-1-okerixx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925125314.16563-1-okerixx@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA5NCBTYWx0ZWRfX2VDeGK62aPL5
 ZFuyGp2m/G2hCQ+j9Q3WyYFIJGxJrfrJNr6G9GCGIoWm4ufgy9HI6w4G8Rj/eu4P6t06ot28Ojs
 zA28JSiLf4FcVYgcNPZfb1NCWNc4F/DFeaDByg8H/dNLLyOXzzncqPtI5QfMhVZOzLEW+qaKSt3
 F48r2VSTDTgPQXflXQEchl3L8WdeXE3zAKSSxJzMt6p6wQUEEadR1yPXXyTG2ZzSPMCMMf5K6Ym
 2CEolfH+2T/2zqnQVfaRmFgGJfd0nrK6iAUw4Vg8g/CW68eUxMEYgAhxb0BifZlwRIO0V8znWQ1
 sRT+gyBstVloVNUFg7IrWwDw2PxooIjKF4XGTxc13ZwEVCIB2b0znphvaM0uZ8cUfKrVo12ygG3
 ZVpIRF/JT3LGU62sR3f/qr8JX2gous+ip2ANqt+fIi18KrI2v64YhpPkLyNtV8dLo4NoBO/vdE3
 5G/Z5nwiB5sceJV9tTg==
X-Proofpoint-GUID: lZa5XhfPsRQ0MGw4TKV7h8nJPOjE5g5_
X-Authority-Analysis: v=2.4 cv=Z8B5j3RA c=1 sm=1 tr=0 ts=6ac0421e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=m9j_GCGoi3mryc8sS7EA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA5NCBTYWx0ZWRfX2F3caLfmH7Yh
 pR3oE/oGnHF1P8oOKlB11rTwEN0lajpXQRLcuU3QatFjlpWa6GnvagTT89L8OjbPtJK80I947T7
 GhGCgzDQsPyu9gBEiphXHkhAPZyoOBw=
X-Proofpoint-ORIG-GUID: lZa5XhfPsRQ0MGw4TKV7h8nJPOjE5g5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020094
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

On Fri, Sep 25, 2026 at 02:53:14PM +0200, Oleg Keri wrote:
> When every training attempt fails, the retry loop in
> msm_dp_ctrl_on_link() ends on a successful
> msm_dp_ctrl_reinitialize_mainlink(), leaving rc at 0. The caller then
> enables the stream on an untrained link and the display stays dark.
> 
> The retry counter only reaches zero in that case, so treat it as a
> training failure.
> 
> Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
> Signed-off-by: Oleg Keri <okerixx@gmail.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
