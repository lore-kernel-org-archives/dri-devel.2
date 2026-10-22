Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1DC60A380C
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IcjvRbsE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gmoenfFM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D9241125E8;
	Thu, 22 Oct 2026 12:58:25 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCBF41125E1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:58:14 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MA0EoJ2397067
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9FguR4Y9REKsLqd5puEfsdMDxnefQWyFrONNXRh4S0s=; b=IcjvRbsEDpPZe3B3
 fum8AuvDyElNqwUPsU1l0gghKdlbH7EVI9AU6ZSXLI+z4qBdKJjLCG9Su5TCi4HE
 J6KMS3EDFyrk5djbxlQlGlBgy6ZKhxIKur8rBMkTlkzzii28nAtd+SogGK3xAkXl
 wuaQl18eDtFzMR1xtGETxHZPXHDaLbvxYSXYio1hVMJtVsPjGLU1CwBwbLE11c0J
 6/rsAmuDMuXLXbo3WmhA6q2z+RFL5EBIDbX2OPwtfXmOELvv9gh1TNPdjEBEhGzb
 eYxgwdRfv48KaH9E1OHiF80L9aiW6h9iSbRbiT61Beu7EXqkyc8VekY4SrthgD6M
 UNbB1g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93buehc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:58:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93caf7856ffso463280285a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 05:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792673893; x=1793278693;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9FguR4Y9REKsLqd5puEfsdMDxnefQWyFrONNXRh4S0s=;
 b=gmoenfFMd9Fu0jnD64qo0iZwaSlT/AB+ARLAdac3urd5SnrSD4aFRWhWdJw5GXXTYm
 olvMGLHuVS2pD9j1lzfuY4R+yc5+AMap5Fy0qZ2HETCdj42WEijNA4P7dewH3nTcbNXZ
 6hGoMpRl7lrP8y3nmIl32HeI4pK2i1QH9NjghBb9rgzgQgzu2ZHDOTkoYRUg/MV3qmyi
 GRT5xijpz364i2bvoIESFBnHM6KH3h64/+Gpy/hiic/9igLnXu4Wo7W6f8XTkamCWwel
 bhZX1YIaMLUbKRs2OptQwxUg9jlfOi/E7bBq60ivkiu8pw98agp5L2dzRQEoIoCYLtc2
 Xokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792673893; x=1793278693;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9FguR4Y9REKsLqd5puEfsdMDxnefQWyFrONNXRh4S0s=;
 b=BPyxz3zrn1hglkSVkvkEYWwChDr7yWbB1CsLddcpe5ckwXjN0mNyMfhDMd4DAkHU+I
 LsldXZwLLg4mW0XVGuWxdTot+UYjbt+Ndi+ZVcQyzZR/T49HigSIEsulx1r5Gmre8zCA
 ZdCg7EOkWLeS2euJY6oobOvd/3n5wnPNCjcMZ5nOpG6KQ9f6Cf4SYBBR6ZnrKOAbhmZ9
 gsC8edY4m6SLjwgSSpjVX0V9PKotJYX3+CKRYDWAlIAkF3cLHm85gsCdWhU8gnrgisF1
 f0tD4YMMGF9TOclP5repjYQO8yrV8XUG1ij5MKifulSBD0z+dhXZo6TIBgP7REJZQhrj
 e73w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPRUP1ay7awJSEENvZKXrEr+KZQeR8hJTU8iWESWJFtsSl2oz+QhPgrq34NsuO+XjPef+lV8DCjQQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJrAFjdx0oIFT2GeQoJ7Mx1kUfie2QCmbp0yZf3oru0T0i/0KJc
 eCK2Jseuu8KvYYIWYI1Zjr1PovDkiG4098/JacQ+xVWvMPad6fmIQnsuQXKD2KpSocjXTFqcv/b
 803zyouEGpU6Kgaoq+SFkQFzS9UOfjoqbUHdKpMpU9fk4rnnrM7fRpMozMURzTOREMgxhnMw=
X-Gm-Gg: AYBFou3y9XSxXgEkoV6sq53RttoNNpvl7NE+e5s1lWtOM2GlF8uletxoeTPoq7u3ymn
 Ww9TIcRFFxdt6KdB3jS3KDevj4Y0R5t4SLPfVnvtHiYU7ZX9PD1zKYmVGdzhrBDIP7RPA8sJM5+
 oZq0zI8o2DpvVAVAfyP/BbI/ZR2E9GSL1XEBvd7wGB1aITqKkTsL3zom5ZzS+4Pw353ZoNOAqup
 eJ4qa8AOsJASMZRQ9hMe6WGqNjW1c1mVWCRQO5LoF/lmeL+y83kfxAanuZ6MCsJ7AqlxbLY1guY
 hDnbhj28ajneI6iZnvhcoKWnEiNzNJyBWAwK426BBE8Ew9vwTjIQY1gLstoqSuVylIPsUPGikR1
 nsJhZY6Z8ga1rX6tiI28huIauLpXDYrlR9VPM/eMx39ccj2wZ7CPE/2guSTyYk7dCdg2FAyvvYz
 AbzqPcn4FPJSzv
X-Received: by 2002:a05:620a:31a9:b0:93f:25c7:a4e1 with SMTP id
 af79cd13be357-93f57f707e5mr913568985a.26.1792673892921; 
 Thu, 22 Oct 2026 05:58:12 -0700 (PDT)
X-Received: by 2002:a05:620a:31a9:b0:93f:25c7:a4e1 with SMTP id
 af79cd13be357-93f57f707e5mr913564085a.26.1792673892359; 
 Thu, 22 Oct 2026 05:58:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac4f668daesm7972101fa.29.2026.10.22.05.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 05:58:11 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:58:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev, virtualization@lists.linux.dev
Subject: Re: [PATCH 01/13] dt-bindings: display: msm: Add Qualcomm DCP bindings
Message-ID: <56bhasxfgn4tpok633n6ho6x5h5jd4tcivmtj3dyppje264dco@5bkmz7kxvsfm>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-1-48aad0fe4f72@oss.qualcomm.com>
 <hprf3vrsveovq3hwcgjrfj6uhmlxlq5u5bx4lkbswgxe476qwz@pacalsdgrjx7>
 <ea81fcc1-c7e4-4b80-b65e-f483487bd1a1@oss.qualcomm.com>
 <f7926ef7-1edf-4d74-9758-2ee0c8a795bc@oss.qualcomm.com>
 <b7kf23jpwkqhpbmytuomofiewx34qxrjn2zqq3ydhnl4jk2smy@bb7h5vecnnag>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7kf23jpwkqhpbmytuomofiewx34qxrjn2zqq3ydhnl4jk2smy@bb7h5vecnnag>
X-Proofpoint-GUID: EYT_b_oR_0wGkyrZaw0oehOwFc02lI7p
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1MSBTYWx0ZWRfX/0G5JwB9ToXk
 ufrXQk9cMqZMMaN4FbaUe6sJ5gmZdusUAJa9CBDYYE/AV2/ljAHrDTNBHMvJzpJwYt6bS9JbIcw
 9gZylKD9GaouoA0PAvtHFGPw7Qtdx/U=
X-Authority-Analysis: v=2.4 cv=F4fC5ahN c=1 sm=1 tr=0 ts=6ada0865 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=Y5PERNx5PWNQqCU0_wUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: EYT_b_oR_0wGkyrZaw0oehOwFc02lI7p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1MSBTYWx0ZWRfX2Umf8L5y0hqm
 7vylllSGLqln/4+qCjuTH8/2U633+JCt8UdEr4u8N4ve5MpwqHY8uI7HkSDgnhtL3AM73Toi4At
 FMbfATWd7KifXt+qJpGRZXLw5kn+psTdA3LtdC1NVyiYPO0dXEx8AdM1rfNux3bl7IV2TB6B17T
 ozHWGIk9ufMwCwiH0XRO4DmXHrenZgSdfWhbEZy5kwiRuoODvPdX+Bm6QU6EAzAcaymjvh4lkcp
 H1YsTGmcme3ylVA9fzvT2dOOIxKaTeFwgvze5lqnVVaW4r7/TQXhWgiZiYzyoYtwHPyctYeIsks
 YqFUkhHOmzspkQPkxiW5Z0gPr9ms/9/WiTeGKlj0jJq/bERuyYW4wMxjCPzj5UGpiv0njkTqME4
 tMpOSktTZIJ1pYdAeYTfoLzNqXyvyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610220051
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 03:52:17PM +0300, Dmitry Baryshkov wrote:
> On Wed, Oct 21, 2026 at 05:09:15PM +0530, Jayant Shekhar wrote:
> > 
> > On 21-10-2026 14:15, Jayant Shekhar wrote:
> > > 
> > > On 15-10-2026 17:47, Dmitry Baryshkov wrote:
> > > > On Thu, Oct 15, 2026 at 01:08:21PM +0530, Jayant Shekhar wrote:
> > > > > DCP platforms place the display pipeline under firmware control,
> > > > > so Linux
> > > > > cannot discover display resources through direct register
> > > > > access. The DRM
> > > > > driver therefore needs device-tree descriptions of the firmware
> > > > > transport,
> > > > > display topology, IOMMU contexts, and panel connections.
> > > > > 
> > > > > Add bindings for the Qualcomm DCP VirtIO display function,
> > > > > including the
> > > > > INTF graph and DSI host outputs. Document the framebuffer IOMMU
> > > > > context,
> > > > > IPCC power-notify mailbox and interrupts, firmware display
> > > > > topology, and
> > > > > firmware-visible IOVA window supplied by the parent VirtIO-MMIO
> > > > > transport.
> > > > > 
> > > > > Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> > > > > Assisted-by: LLM
> > > > > ---
> > > > >   .../bindings/display/msm/qcom,dcp-dsi.yaml         |  75
> > > > > +++++++++++++
> > > > >   .../bindings/display/msm/qcom,dcp-virtio.yaml      | 113
> > > > > +++++++++++++++++++
> > > > >   .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 119
> > > > > +++++++++++++++++++++
> > > > >   3 files changed, 307 insertions(+)
> > > > > 
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
> > > > > b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..f7178c66c09e
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
> > > > > @@ -0,0 +1,75 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/display/msm/qcom,dcp-dsi.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Qualcomm DCP DSI host
> > > > > +
> > > > > +maintainers:
> > > > > +  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> > > > > +
> > > > > +description: |
> > > > > +  A MIPI DSI host exposed by the Qualcomm DCP VirtIO device (see
> > > > > +  qcom,dcp.yaml). DCP is a firmware protocol shared across multiple
> > > > > +  Qualcomm SoCs, not specific to any one of them; Hawi is its first
> > > > > +  platform. The DSI host and its connection to a panel are described
> > > > > +  using the standard DSI controller and OF graph properties.
> > > > > +
> > > > > +allOf:
> > > > > +  - $ref: /schemas/display/dsi-controller.yaml#
> > > > > +
> > > > > +properties:
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +    description: Index of this DSI host among its siblings.
> > > > > +
> > > > > +  status: true
> > > > > +
> > > > > +  ports:
> > > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > > +    description: |
> > > > > +      port@0: Input from the DCP virtio device's DPU INTF output port.
> > > > > +      port@1: Output to the attached panel.
> > > > > +    properties:
> > > > > +      port@0:
> > > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > > +      port@1:
> > > > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > > > +        unevaluatedProperties: false
> > > > > +        properties:
> > > > > +          endpoint:
> > > > > +            $ref: /schemas/media/video-interfaces.yaml#
> > > > > +            unevaluatedProperties: false
> > > > Why do we need OF graph here? Would it be enough to link one of the
> > > > ports of the root node with the panel's input?
> > > > 
> > > > > +
> > > > > +required:
> > > > > +  - reg
> > > > > +  - ports
> > > > > +
> > > > > +unevaluatedProperties: false
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    dcp-subsystem {
> > > > > +        #address-cells = <1>;
> > > > > +        #size-cells = <0>;
> > > > > +
> > > > > +        dsi@0 {
> > > > > +            reg = <0>;
> > > > > +            #address-cells = <1>;
> > > > > +            #size-cells = <0>;
> > > > > +
> > > > > +            ports {
> > > > > +                #address-cells = <1>;
> > > > > +                #size-cells = <0>;
> > > > > +
> > > > > +                port@0 {
> > > > > +                    reg = <0>;
> > > > > +                    dcp_dsi0_in: endpoint {
> > > > > +                        remote-endpoint = <&dcp_intf1_out>;
> > > > > +                    };
> > > > > +                };
> > > > > +
> > > > > +            };
> > > > > +        };
> > > > > +    };
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/display/msm/qcom,dcp-virtio.yaml
> > > > > b/Documentation/devicetree/bindings/display/msm/qcom,dcp-virtio.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..018694310dfb
> > > > > --- /dev/null
> > > > > +++
> > > > > b/Documentation/devicetree/bindings/display/msm/qcom,dcp-virtio.yaml
> > > > > @@ -0,0 +1,113 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/display/msm/qcom,dcp-virtio.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Qualcomm DCP VirtIO host
> > > > > +
> > > > > +maintainers:
> > > > > +  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> > > > > +
> > > > > +description: |
> > > > > +  Qualcomm's DCP VirtIO host provides the generic VirtIO-MMIO
> > > > > transport and
> > > > > +  the host-side IPCC channel used to wake the DCP firmware.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    contains:
> > > > > +      const: qcom,dcp-virtio
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  iommus:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  iommu-ranges:
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > > +
> > > > > +  interrupts-extended:
> > > > > +    minItems: 2
> > > > > +
> > > > > +  interrupt-names:
> > > > > +    items:
> > > > > +      - const: virtio
> > > > > +      - const: dcp_power_notify_irq
> > > > > +
> > > > > +  dma-coherent: true
> > > > > +
> > > > > +  mboxes:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  mbox-names:
> > > > > +    const: dcp-power-tx
> > > > > +
> > > > > +  dcp-subsystem:
> > > > > +    $ref: qcom,dcp.yaml#
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - reg
> > > > > +  - interrupts-extended
> > > > > +  - interrupt-names
> > > > > +  - iommus
> > > > > +  - dcp-subsystem
> > > > > +
> > > > > +additionalProperties: false
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > > +    #include <dt-bindings/mailbox/qcom-ipcc.h>
> > > > > +
> > > > > +    virtio@9be8000 {
> > > > > +        compatible = "qcom,dcp-virtio", "virtio,mmio";
> > > > Is it really compatible with virtio,mmio? Can it be handled completely
> > > > by virtio,mmio?
> > > 
> > > 
> > > There are two possible approaches:
> > > 
> > > Option 1 — Use the standard VirtIO-MMIO parent (preferred)
> > > 
> > > Keep the parent as:
> > > 
> > > compatible = "virtio,mmio";
> > > reg = <...>;
> > > interrupts = <...>;
> > > iommus = <...>;
> > > iommu-ranges = <...>;
> > > dma-coherent;
> > > 
> > > The generic virtio/mmio.yaml binding would be extended only to document
> > > the generic iommu-ranges property.
> > > 
> > > The DCP-specific resources would be placed on the virtio,deviceXX child:
> > > 
> > > dcp-subsystem {
> > >     compatible = "virtio,deviceXX";
> > >     iommus = <...>;
> > >     interrupts-extended = <&ipcc ...>;
> > >     mboxes = <&ipcc ...>;
> > >     mbox-names = "dcp-power-tx";
> > > };
> > > 
> > > The parent uses the standard VirtIO-MMIO interrupts property. The child
> > > has one DCP-specific interrupt, so interrupt-names is unnecessary and
> > > the driver uses interrupt index 0.
> > > 
> > > Option 2 — Add a Qualcomm-specific VirtIO-MMIO parent binding
> > > 
> > > Keep a Qualcomm-specific compatible such as:
> > > 
> > > compatible = "qcom,dcp-virtio", "virtio,mmio";
> > > 
> > > and extend the parent binding to describe iommu-ranges, the additional
> > > IPCC interrupt, mailbox, and related DCP resources.
> > > 
> > > However, this approach duplicates the generic VirtIO-MMIO binding and is
> > > only justified if the transport requires Qualcomm-specific handling.
> > > Since the DCP transport is handled completely by the standard
> > > VirtIO-MMIO driver.
> > > 
> > > Which one do you prefer?
> > > 
> > > I will be addressing other comments in v2.
> > > 
> > > 
> > > Thanks
> > > 
> > > Jayant
> > > 
> > > 
> > 
> > I think Option 1 is not suitable because the IPCC power-notify sequence is
> > required before the first VirtIO-MMIO register access. The standard
> > VirtIO-MMIO driver would otherwise probe the DT node directly and access the
> > registers before Qualcomm-specific initialization is complete.
> 
> Good. Which means that dcp-vrtio device isn't compatible with
> "virtio-mmio" and can't use it as a fallback in DT.
> 
> > 
> >   Would the following Qualcomm-specific transport approach be acceptable?
> > 
> >   - qcom,dcp-virtio is the DT-compatible Qualcomm wrapper. It initializes
> > IPCC and sends the required power notification before creating a synthetic
> > virtio-mmio platform device.
> >   - The unchanged generic VirtIO-MMIO driver probes the synthetic child,
> > accesses the MMIO registers, creates the VirtIO queues, and registers the
> > VirtIO device.
> 
> Why do you need a synthetic VirtIO-MMIO? Why can't you register a virtio
> host from dcp-virtio? The driver is not designed to work in that way.
> 
> You have two major options here:
> - Copy relevant parts of virtio-mmio to the dcp-virtio driver.
> - Turn the core parts of the virtio-mmio driver into the library, making
>   it possible to share the code with DCP driver.

Anyway, please cc VirtIO maintainers and related MLs in v2. I'll add
them manually in this email.

> 
> >   - The DCP VirtIO driver binds to the resulting VirtIO device through its
> > VirtIO device/vendor ID table and initializes HFI, firmware capabilities,
> > and DRM/KMS.
> >   - The virtio,deviceXX DT child is discovered by the VirtIO core and
> > describes the DCP-specific IOMMU context, DSI hosts, display graph, and
> > panels.
> 
> With your suggested codeflow, what happens if the dcp-virtio driver
> suspends the DCP host, making virtio queues unavailable? How would
> virtio-mmio know that it should also prevent the access? How would you
> suspend it too?

-- 
With best wishes
Dmitry
