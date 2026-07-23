Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1252CC531D4
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 14:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6871E10E5A9;
	Thu, 23 Jul 2026 14:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oclqc78F";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I+Q+dcsu";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E41CB10E5A9
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 14:52:33 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NCvkTC4050184
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 14:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6BuEKfXEzT6vDZyFzbYENFwq
 P2ZCaxQDHcuegPMajFs=; b=Oclqc78FRFy0zdixA2Y3PwskeExSft32Q9TAcno1
 DoClNaOebgIgx6+EOyz+3zErI62uO95sWF4ZN1Cz0V7yyIVS7h+KGLxGGtCHhabs
 5MUO/kRqWIQ8WRaFQQZVsg7qssyGR5Sfshu2ssUp+/C8yLBv81CPykEnqwc7stFb
 wRdj5TFrDBXifcVCCa2MyKF0XW/KGqponjSOs4cpnn+Z/OYwbBhbznBf5+Wy5Peg
 p/NmqVSMaEzuAFqL2aEEKKyCCjc8g56BXbw4Ci/qSawK5m9Qf0n8Vs5hmMJkzHtS
 C7ZmxiPUxLl98y9Y2cdo4K2uquLoLcfee0YmIaGMqbec5w==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk28vmpy7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 14:52:32 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e6027a5761so481140a34.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 07:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784818346; x=1785423146;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6BuEKfXEzT6vDZyFzbYENFwqP2ZCaxQDHcuegPMajFs=;
 b=I+Q+dcsuPV8NIqtpXIzJmP+5/JW14aLssKLtNxe6UKfdWQm5HRnYKTTYI/Pxf0DLqo
 t1PrLIdkC+nxXfnBstUcX7MBvKui7Uyx8Iylso2DGn9r3cZ9ibp6gKT6V2JukeKQQebj
 PZqv+SRvH+QWly7hI8JH/lznws1FoUsaPtJ8bJNkA/CnBNBiybi1poC1j9tuG/LawzYt
 k00tIAN+qZB40St92yEpsF+3EpaKg9flIlD7DdeAWlm3kUZa7WL6DyGcta4vqqxIo4TJ
 1CjIZQjyxnP9zuU5SZh3dG2DRvPjDT+Xk6T+mMl2Elo0USJFSC2L0Uth2Nu64Fn23zkx
 +prA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784818346; x=1785423146;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6BuEKfXEzT6vDZyFzbYENFwqP2ZCaxQDHcuegPMajFs=;
 b=Rew7UWGMoLTmLGz+Ns4X2o1OLiAnZb0ZWplgpiAEKwISlzCM9YMHzDoPv85ptDELQw
 x+LyRIwuyhvPFPLlLfs1IB5gaGYoI+N2kp6EMS1dq6T1onAhXIeWtUuzPq3oq3eO4TtU
 481zaIZdAPOXx7Urs/ic9cLDuSpTsVUoOkKh7fCI/dz5OiJrOhI1N1LOYnOHMHTk8RZw
 nGkIMpoU52BCKyCwg4Pq1loQp2XR0J+2+zTfx5dhY4xoVTgW0AA3djKPgaT3eyHgg8u7
 M3F4ChvI9DTvNWnllGbL3NXPA8KGMFNFvM1tTZYR1IOxlDmNMX+7M/i58R9yQdDsR3mk
 27wA==
X-Forwarded-Encrypted: i=1;
 AHgh+RokMeQQ6MHMyGF62rKqcbSlyd+tGs/GjxNkvbWXrmgT3mwaCoTTr3b+j3hw+T3J+s1yYKZcgK4eqdU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxASBCs0/uweF7sPi8SThZaNnMlxc0VBoQwIObdMNpI8Ll87aKQ
 DzG1q/rAfCB+ITLOKcwNVGyVdFeirqGp1e2XfZHNkywPkodLLRgliwFPXwRmJMWUZHFtft1Uu/f
 k7StrZlKYza1ftLy0AnIGWXon7zMfYYW3bkPIw9kOvU04JuDI6yT65kuJldx3qAEs1SIQ4+o=
X-Gm-Gg: AR+sD11ZcFa7KlfcOGNhsZTofWD3yfOZ2qPohJu2jJ64gvwQhjXQskZBFDgPrBV6Anu
 cgtogKHu7xjVQ8FfC4fLFQFwBKfWg6DEyHmjm2cgk/7MCHsYbSTGZMrfSddrotD8mbw9aWlFcdM
 9WQbby86WWswq6b1bo+kwfGRdPRrN8xCmsq+bqqcp8s81ucpV/kvuhTXMhIZczu4+bySM7m4Ezs
 SSOm4E0xr7h1WyUJKTTsV1rFfRp0aK8VCK43n/9W9V7C/XTHlUK11mYXhRwZdwAPqVeEsoXyurI
 vZH2yNM3z8sLYi25FEFh4PYR3iy9b+JdkgjDiyd6hhDGPBIFqi3KxPsM5t5kMB+v5oyyZKR/mo8
 hKNwa6ygBzc/97kaF/UZS97hOGxxtUho3tl4C9bC8eiaRn0wzrLFs4eLdjiGqnS4vbpZ+HHqlv7
 sn9oGmmn3sW21YF2nIjOfm
X-Received: by 2002:a05:6830:81f6:b0:7e9:b772:9ab2 with SMTP id
 46e09a7af769-7ee52dc0600mr346515a34.7.1784818346159; 
 Thu, 23 Jul 2026 07:52:26 -0700 (PDT)
X-Received: by 2002:a05:6830:81f6:b0:7e9:b772:9ab2 with SMTP id
 46e09a7af769-7ee52dc0600mr346499a34.7.1784818345693; 
 Thu, 23 Jul 2026 07:52:25 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ee4f10b691sm785096a34.5.2026.07.23.07.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:52:24 -0700 (PDT)
Date: Thu, 23 Jul 2026 20:22:15 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com
Subject: Re: [PATCH] dt-bindings: display: panel-lvds: Add boe,dv215fhm-r01
 compatible
Message-ID: <amIqn2rJhgjkHDMS@hu-vishsain-blr.qualcomm.com>
References: <20260719-b4-lvds-panel-doc-v1-1-6a18c213c2f6@oss.qualcomm.com>
 <20260722193954.GA1559082-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722193954.GA1559082-robh@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0NiBTYWx0ZWRfX+BCosgkv+ZJA
 ey+i7We0mLciZQg3nfJRxYXX63u/jzFqr3jIHunq0lfSWJxijk+dVrhQy2lYgDXpctqPUeMqZrl
 EJNqv7BB8sgSbXs1A2VNs1b/vW6IDHY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0NiBTYWx0ZWRfX0l6hsFNyE4ck
 4zWd7dfa/YwhFJeFVWTDzIRui9E70D3A2GtNrN5L/hCjNKp8m37PFOD7cUeJfoIBQRE/Bpof478
 QceWuLaLqSjS9NHTZ1xw0MxucuFyqoDAGVaNJoIxfG9xP6PqoaNKJxl4RdTN5vENxmbBhbQcoE3
 uW4Z7Jn4qnU5/ASQ5nFZTRuZ2Y5YQ8bNYYLm0+ZUepWAXT2pAaTFx2H7jz5+sqxY2UYxXS/iWpJ
 CANx621CPFnEKw69zRGZ+9YWreRuhYdGgbhbbmz3vEex7XPgEot/nfV9ApdqWZrHKN+WseULuAL
 yXAVUH1JZ1pTW9NhNkmUxMiOKqcNaKtAg0jgM+6tf/iXGxsWZ9mlAdaEu6H+KKrZreyn2zEEteo
 Mbwnvdcu+9sMQeHV7EP1HnbkV5YduLRM8OpuMk+JMMiufUm6/InWO0ojr5TpgCZg6LDKJqdt/8B
 i9msKkcKoL0aSUIOT5w==
X-Proofpoint-ORIG-GUID: N3GO1tC7OAJgMPj3AvTY7Jk5dYCXV9Gx
X-Proofpoint-GUID: N3GO1tC7OAJgMPj3AvTY7Jk5dYCXV9Gx
X-Authority-Analysis: v=2.4 cv=D4V37PRj c=1 sm=1 tr=0 ts=6a622ab0 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=uidagIbUEOmi54HA150A:9 a=CjuIK1q_8ugA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230146
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

On Wed, Jul 22, 2026 at 02:39:54PM -0500, Rob Herring wrote:
> On Sun, Jul 19, 2026 at 09:38:36PM +0530, Vishnu Saini wrote:
> > Add BOE DV215FHM-R01 21.5" FHD (1920x1080) dual-channel LVDS panel
> > compatible string to the panel-lvds binding.
> > 
> > Also remove the 'port' requirement from the required list to allow
> > dual-channel LVDS panels to use the 'ports' graph topology with
> > separate port@0 (odd pixels) and port@1 (even pixels) nodes, as
> > required by the dual-LVDS binding.
> > 
> > Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/display/panel/panel-lvds.yaml          | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> > index b89f86bc0683..584818b2df6e 100644
> > --- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> > @@ -58,6 +58,8 @@ properties:
> >            - hydis,hv070wx2-1e0
> >            # Jenson Display BL-JT60050-01A 7" WSVGA (1024x600) color TFT LCD LVDS panel
> >            - jenson,bl-jt60050-01a
> > +          # BOE DV215FHM-R01 21.5" FHD (1920x1080) dual-channel LVDS panel
> > +          - boe,dv215fhm-r01
> 
> This belongs in panel-simple-lvds-dual-ports.yaml.
I will use this path in next revision, this will also change DT. 
> Rob
