Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167C9CA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3160C10E96B;
	Fri,  9 Oct 2026 14:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VbYUQwuJ";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PAYC+IWe";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D693710E96B
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 14:38:22 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699DKeBu887308
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 14:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UMVpMFCHtMG0Xn67lqGB8w67sz48UmLUXf0QKHiAu9Y=; b=VbYUQwuJPCbtoeVX
 m7otJFYOvB2nJ/0eD5rMovP6i9TEsL9EsY+aAjWGwu4BLzi+Cow5JCrCB0CpVwpc
 KCqXEBJThkepkP4ptknCDiKzHIua9stKQaMJCjZ2OedHblO1CwJtlYJe5tyV9rpu
 zuH+iDR3Gu/xBamKr5oMgVhPrcqdRvt9a6NZNcjuUgHnC/Nzg262hRdLYGi+Lh06
 YBh4CgVsDbBkT7VgKX38+3M/mXE1SkgvkmZY007Urf4ET0KiRlXMmeMGuIl3ut8G
 4IeuA77qbU7JY5aafiRsZCu/gCck2jBsIXIWm8E1ufCYrq96pI5kCmefSMsxzfrZ
 bOVO0Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxu3xp2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 14:38:21 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1ca15334cso6534217a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 07:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791556698; cv=none;
 d=google.com; s=arc-20260327;
 b=AOl7JnywUU6JVveEunv3hEJOtKEgjmYXywgwk47+7m6L9fyJTugGM3VC9iUVO6x1JR
 euGcn3qp+0wR3upJ/6UKWClem3bzCH+vJztbvTCqb+ug9tIETxB7SSNIGl+PV5J5Cc7w
 /lmPgrvdD8O6Bw4KTkzjBXemfVvvHJ2za5sCrw7eP4nsntUCFp4YAj+zGanOodwsvOl2
 9lOmAgSJAFcOJFQ7lGSJl0Is9JCITUBEz8epgG25Gwmg0dvJhrISP0UYVL40m8s/kdim
 NnrWdwOdHnw9gY/cTIx+39pPUwPPBFI5izvvZhFRDlEPosa0S3QeQWLS6aQACPn/wpd8
 3llQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UMVpMFCHtMG0Xn67lqGB8w67sz48UmLUXf0QKHiAu9Y=;
 fh=ApWd12nLBkAagkm9muTENqXE4gPQuuUpA5d5jT/B1HQ=;
 b=qQxHvpboIJ42uVe8eX7NE0PX+Hm8fQQNCXUnhcFUsRIFBJKysqqjRHZs0gYv/qXr1p
 Z5WMQrUau6lA1EPiK2TKib6EcK4hHpUYN+3bri1wtkIFQJOBE4k3zo29q/0qBNSNinf+
 FmWu6+/swiJ8ZyZJROM4Zt64r8kLCxjV1hU12CQ72Zv7cpk2PzW+nV36SzCpfyJ5YI3b
 KuYHesIYJcNmDMcxC3xbeL9NuDRTi/gpnoD8/q+rR6y3Vnm8kMUG6ix2D9Hl16GrJFJQ
 CGaWyJJIxgrS3uufm6XF5tvhBPIjtAgE7uL3oCa6/DmSLOWAmtFN3VqiXYwFx8hm/ZAZ
 jzXw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791556698; x=1792161498;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UMVpMFCHtMG0Xn67lqGB8w67sz48UmLUXf0QKHiAu9Y=;
 b=PAYC+IWeHhg0qRUCbH6LBH2mZFcR9+4uj1rbf1GFn9HIulSjYN6+t1xVrSJvB2CCfZ
 D8WVkmQD3SpEN8VnZdKRsofWmJYaWeqKQ33mhaHMrKzuzXn8rTo6duvexcoIMTfZb2TI
 hshd1LjKOGp7hNMlWWKrdDsgrFOxu+/XKO8+bFLvIZkpAjQx6Jw9wKBkLgQZZ2pfgCME
 H+jEzYCs9YNkcumALkHli9EYFcrNJs0fCO9LTy5W6YRilfVbAaTO7OOdKaXL7KQEt7aG
 rLT+EamdHO9l25PR8LXC8L7kyVfRb9NCUd59zx2yaFQKWhCN6cRiPck8YfrZ5e+wANCl
 lVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791556698; x=1792161498;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UMVpMFCHtMG0Xn67lqGB8w67sz48UmLUXf0QKHiAu9Y=;
 b=Rry0VxOqY71oaPxlUm9VSm2HvJNbb89bMzJNsT0HQ50AGzsK1pRHX2lTbGiXO05MV9
 oSndjUHt2momTe3Dgqametw/SADJgjO0oA6VXBNorxbbXbki8FRrU/Krbm5flgX6t5TX
 VRDX1k8c60GxzpigEa+Cohbv1zBJsGZDjRJfMMlddxfYIJT7B+5tqVqciQ4pUCzTsM4r
 rEDABAfHaj37kk5SSIzM97YUFWdQiRGDfuHOknIZy2dzZlk0dQzmwoCC0m3d8hgmghqf
 KA0fGYxPoRWwV2TpWD3fO4R0W1MwiYaUOIGnG78WTCaihuiyjfdez60aPa99LUOM8FcY
 2Mlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyZUrBCPZ1b415fgyJpESjncGZj2oyrLzOdIy1Up5GUfmeZ5OV1r3s6POI7Ul9a0TmM0dF9ZbxSHA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIMUWx9MF67EPgRtYw9+BT8u8TUyNT3iKJtP8Up6D0Q/xeogWz+
 mULw3ajLVrSnh+CuPt+WHdIY/S/XDX5Sxq+EyQFgWt1sb+UFyme63J68NtaxU0RM6fCwuWkAmG8
 Pd5ECLXIfMYWu2hfOrlWH2D11Y0ROQOwc0jx824gkCMsD3Ea8l7+r4FmQyhWbUmTKyA2BhSKt8d
 V4J15uqmDQv0NlWbEKsnlnxsDR73RJvggTGLz5366LL8P7jQ==
X-Gm-Gg: AYBFou0N8421mY63KkYR+aP93UikkzvstVPfWC8K4ET+fWDDO5ULfvbVQxR+h3GyXC+
 TNrJLwoERy5Ed1uQx8XxLfm+PqTgdCbmIHiDr9fZD7pmCIM0I5ADbVV/ShCxUqU1jiob6SPv9RX
 ek8kIrZZy2/JirH8bf5h57arjqHNWC8dzbgK6qzX970hjXQmVkkLqokv9BtQ==
X-Received: by 2002:a17:90b:1e41:b0:3a8:9b79:e6ea with SMTP id
 98e67ed59e1d1-3ab3a96ffd7mr2186013a91.59.1791556698414; 
 Fri, 09 Oct 2026 07:38:18 -0700 (PDT)
X-Received: by 2002:a17:90b:1e41:b0:3a8:9b79:e6ea with SMTP id
 98e67ed59e1d1-3ab3a96ffd7mr2185985a91.59.1791556697914; Fri, 09 Oct 2026
 07:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-5-9352be6b86b1@kernel.org>
 <CAL_Jsq+1O+os8=YGUoKg6zCm-r0gQ35baKX=z65uTQNB0i=RVQ@mail.gmail.com>
 <CAD++jLm+yRo9e1UDhnaYrdPq28mdyYKQZ6tdKuUa3UG85imkNA@mail.gmail.com>
 <20261009131902.GA1195061-robh@kernel.org>
In-Reply-To: <20261009131902.GA1195061-robh@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 16:38:06 +0200
X-Gm-Features: AclHuK-dvh3nBN-NbcFTG0ZbDjXuEqk09evXIZaWdeTMn5nwqDOFCebwqJJJ9Ag
Message-ID: <CAPx+jO9F6wUG9M_cV-xiF-KAKD5kJ02n+yE6L9vocs=KWaKFTw@mail.gmail.com>
Subject: Re: [PATCH v3 05/18] dt-bindings: display: ste,
 mcde: Allow power domains
To: Rob Herring <robh@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1OCBTYWx0ZWRfX5OYb3n8eOh0T
 RkBEON1RARte8aHJG/CVvBV8X4atEmqbm7beGwonM2wAdpfQJyMwgOvzuZx85FSMC8KWJMCWDBy
 ofLskUHppM7zyu2jQQ++ByiJ3LcuQvnSDSKQCRt4Dwihw4ac5YAn9zWs/5ThvzCl0WvT4vl8GWG
 xbJd8W11TEWP+2s61aGdi86utKSkqbMkCbGyOrYlZQ0U4XU/wVooZW+YKte9x+PISapp5tapeso
 lsLZCRE1R2jJeLLygb0cEIGU3dRU/1oyXEQdVxv6bvVoQkVmlTu53lT1UXoei6cMYayE+Twnj5i
 Gzi94teOAxe66vR2Jq8SEVeafT1CWOizQEJOfoa4CJof/tTCby+/sH2UIp0XvZNeg2FO1Gn06Qf
 KKIQCDWHRACJodBddz3UPrMq/ulf3ThojN7jEdYHEfd5U89IBJv0R/DRFunewfFzH57v04nbMt5
 mRfdnqyD0SZIKeQf+rw==
X-Authority-Analysis: v=2.4 cv=QbjzLcbv c=1 sm=1 tr=0 ts=6ac8fc5d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=sRttis5sQqJQ8Uet4gEA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: CNQVY6q0KEP7GfGI2e_5_cxqqe2q9S4k
X-Proofpoint-ORIG-GUID: CNQVY6q0KEP7GfGI2e_5_cxqqe2q9S4k
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1OCBTYWx0ZWRfX4myqGoqhqsB6
 zxx3V3aYl9E5UsIgo1V/Wu/ZDcPqbpxiZp9JUGb7mi/hE65kkjnLTlnhOuubp5PGLn6J/0t9Ts3
 kENmuvjxNEEfNZ9rNf+PZ6LvMHcqBDs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090058
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

On Fri, Oct 9, 2026 at 3:19=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Oct 09, 2026 at 07:05:46AM +0200, Linus Walleij wrote:
> > On Thu, Oct 8, 2026 at 7:41=E2=80=AFPM Rob Herring <robh@kernel.org> wr=
ote:
> >
> > > > +      power-domains =3D <&pm_domains DOMAIN_B2R2_MCDE>;
> > >
> > > This patch is in next, but the define is not breaking dt_binding_chec=
k.
> >
> > I screwed up, I forgot the dependency on the new define :(
> >
> > I asked Ulf to merge the prerequisite which would resolve it:
> > https://lore.kernel.org/linux-pm/CAD++jL=3DgFt9kKZH9T-m8B_pbwRvzc35tTrM=
n5V238d3528DpUg@mail.gmail.com/
> >
> > Is it very urgent so I should just revert it? I could also just merge
> > the single patch adding the defines into the drm-misc tree if
> > Ulf is OK with that.
>
> 'make dt_binding_check' errors out. That kills my bot for anything based
> on next which is most patches.
>
> You could also just remove the define from the example.
>
> (Note that drm folks require a revert be posted and acked or they will
> revert your revert. I learned the hard way.)
>
> Rob

I have queued up three patches [1] for next from Linus via my pmdomain
tree. The patches are also available for you to pull via my immutable
dt branch. I assume that should resolve this problem?

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20261009-ux500-power-domains-v7-3-rc1-redux-v1-=
0-5eb1b90bc35e@kernel.org/
