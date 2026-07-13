Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E761C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C625310E8EE;
	Mon, 13 Jul 2026 10:29:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QNFOxgh3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q64Y2H6u";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA17B10E8F0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:29:17 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D9R8nB1122927
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ooopbZ8BXUYSj2UczjbYKP/YkkGSe5M/iCnsrnvSEpM=; b=QNFOxgh31F+aQwWH
 ovN+MuWYrQupUnEJ4E05qCBe2S9rP7KHAIzWX8QuWwVLkBnQCTy1Hz9uUXC1S7DF
 8ziWPWrYXfAPxVQX7yIQ90tkfXiCc0VPr519QCrHicbq5mx/va6EOAY8OJvHnMC3
 RZF+ARzvL1gWrkTRgAmMOSEPMRMgnJsk3tSucarsmgrls/L4q+xlgyoSuIM/bgkt
 B+B96eVD2U0ghoOzlEzmHlymMGN9Zy4snq+v8VItrjMOWQ4hjzJIFO+xwOz3UgBn
 1yZtKxrH/rfPDe0dXOHL2JQMVO51Kqi381IJox02JTjVELMpumm0HRsXH/c9hr2z
 cyqT8w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwda07ch-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:29:16 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f000e221d7so49099286d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 03:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783938556; cv=none;
 d=google.com; s=arc-20260327;
 b=JYVb9RNZ5KgfLSadAkHo1M+UZY1bdPnq1+f7XENLy4RDiOf50jOO+RMXiGv25wVXd6
 yL6fLHfcCmY60Mu4fUe5dYa8EkA9kMIL2Z/iVRbcM9RlQrzVikJdGWwqR8NuXofIonXo
 3YDp5QYJdqYqX9vqLu/bRXX0+lweVfrllKmAOpHmVyCN6Wz4009iEfW8E9KYw9EXJ56c
 h1l8DE3O0oUUel8UM+2JFqp15q6LexeP85onPT3Qtx9UKzWABQE7iONuGIxj/G1cZEdC
 oy6MkZOz2gNmMq8Gta1UQBrMt/2ZEiJ/bq2Oc+65g+mHE08FOA4/6GBorFHlJAp6gbgF
 /Ygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ooopbZ8BXUYSj2UczjbYKP/YkkGSe5M/iCnsrnvSEpM=;
 fh=GbnNRl/lEkx+XrjV7qV0M2IqSUn9/2H0uk0MB39bvU4=;
 b=l2u3gbAb8NJDFk4WufKQS8fcbAnZMi3VHlFbBt1I8+bQ8ishguk0JJMUw/gjhJUKyp
 Wz0R53UYz10EMhaiN8XBjKwfr+6B0/0QyhhVyzbg2QIBDE67hZf+bo0Jr9lBJXT8q7QJ
 ZLP27dTGAPQEIm5liY0DguWjbS3miMOunEnqCEJ+vS5NtOWEt8ALfPjTcoxGb+WO0u/r
 wJ4erXV5ZiL4eIQqWbnzkr3sWHarzbJQTBd2PujBy0XrAuqSxljFhc9sajwPFlvk1kNI
 I+vsusiThvstJqWV/R9pnYI1vTtbds/Xdzc0rDYG7vhGYPBA5hRd9C/cANmzmJHkvEeM
 3/9Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783938556; x=1784543356;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ooopbZ8BXUYSj2UczjbYKP/YkkGSe5M/iCnsrnvSEpM=;
 b=Q64Y2H6uwfNWxZ6T+epJxFKJJu2niQbi6Fzu9H6nFfgppaEV78UvvyiO7rQPqIxu6L
 W2SYNFPVBGBiBAYPqo4JHHGN9Kgmk/VYGox7J42kEs9RpngMG7cMhT4CHIxhl4xqvLzq
 517eO+sSYEFAZoSkdzvMc0puJ66+7qeqJhsxi72AiD4Hw0ASFoHyIwsNRk996G7YobgU
 y4dK6AXN4HrxBrHHpb3Feg9Jys3sfILCUBkc0hSnWkiUx7RTrWo8XfonfxwprbJalOEw
 dAXk6LlEIJ4iHMJmcFkBBgCPw/RR7ZmQa5oAKI7nJSn0aHHkfonDU5AhT1cg4YCsNlBN
 hHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783938556; x=1784543356;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ooopbZ8BXUYSj2UczjbYKP/YkkGSe5M/iCnsrnvSEpM=;
 b=i/pWuAVoO1ORhOgxS++4/wJF6x0xAet6wTv7i3ZQ2e7YvxugBvkZc4sa7gMVcPwZMN
 ICgu2aTOPT+fsT+d2Zf9wL5eqoNvCQi1fl0cBPpr6g44Z3AMHFl1rWT1YBj/mHbZRQsz
 YT0aBDsrWnwo2Rb2wIlnGcZLZ1aDoU8KMkx6ykh0x6SPW12FT4q0lZz0/wmKx+x+4Qlg
 I2VAtqPwDKV1QqH0QSB5OoIzZHmS4Psm3YUHUwWsZovuvIYrsFkr3tKWMXYjp8BKDEk0
 VZThpRZ7FN0nGFswVbX9L6a7un2GL5DqPssaCA1uDPSMq1gBB+KRgrnMCWfb+yXuohdu
 jRfA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrV15YMiwtYfihIVt5MKVaI53wzd1VcCmzg1LpeqfrX6WOx1ioFNdlLZokjNU0Jw1R6mGsjQEKWdqw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwCgPV3fdVVuyACcyD2gqWdmlGUnE1vroK+vkM+nUzuvbf1sQ29
 zYFmEOGZkxr0HgROthxJt2Iw64fuktVh0Quek6wOLarcKjZmnCmV9eSsg7fwRvLMondTFcj8BKU
 GFItNCSx0rJCE9PAmv5Ldd7b4H19nRqklUcmSkvhivDkOhxIhLUgxpfwIAxyKuX9f0CWTRkkKfF
 pwpsxrMHvURg1y4SwNnhp3OcwbLd8v5Q9ZWcM0E6OyVdJD/Q==
X-Gm-Gg: AfdE7ckkxyk0YGZ+Ge5QTe1GizqdXOHX0+lcjxH3WgA/voAn3AZ7cPcho8ozI/INcRH
 8w8IbES/cNoYJqUPnkSU8mi3IyUplUiejRxzoV+RdWaLk3Fbk1GJzk2xMr7uIFgKjPF3Qsew4gr
 Mypv2v5C2FnVJ6BzXMM2LgeobmFHRFrRjIdzy+sGYEC05syNH9B4IbBGDzfoo4srviuHD8
X-Received: by 2002:a05:6214:238f:b0:8dc:2c21:32bd with SMTP id
 6a1803df08f44-903ff76144dmr97564836d6.1.1783938555915; 
 Mon, 13 Jul 2026 03:29:15 -0700 (PDT)
X-Received: by 2002:a05:6214:238f:b0:8dc:2c21:32bd with SMTP id
 6a1803df08f44-903ff76144dmr97564106d6.1.1783938555502; Mon, 13 Jul 2026
 03:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-11-1ff028e33779@oss.qualcomm.com>
In-Reply-To: <20260706-pdev-fwnode-ref-v3-11-1ff028e33779@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 12:29:04 +0200
X-Gm-Features: AUfX_myf4-1EuuJEsM9iEruoBmhvEE1_shBmpnLHYi6rPSO8vgxEgiRb5eZm2os
Message-ID: <CAPx+jO-P3Yt6T5Kb97MjmMB1mYeEgjStCkSACM_wsrqsBVFEvA@mail.gmail.com>
Subject: Re: [PATCH v3 11/20] pmdomain: imx: use platform_device_set_of_node()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Srinivas Kandagatla <srini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Peter Chen <peter.chen@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 driver-core@lists.linux.dev, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 mfd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEwOCBTYWx0ZWRfX6Ba8XE1wx5Bf
 8cdrX4q7l8MTUQGnT3GOlZXJHBVRk+p7CLQqYgswFofOFVpacxK8POThgf/nwQOslYYxmU8WCiW
 hfCn/70thl4eW6emRZMm34KVy+Rd8ic=
X-Authority-Analysis: v=2.4 cv=cNbQdFeN c=1 sm=1 tr=0 ts=6a54bdfc cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=-ghbRyKqcrg4NgclPfMA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: GKo3okwjOZdPFzbccnwD-2qwb9cIQpKZ
X-Proofpoint-ORIG-GUID: GKo3okwjOZdPFzbccnwD-2qwb9cIQpKZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEwOCBTYWx0ZWRfX91dZXsshze3B
 smvRF+E2zxi8HwOtRqGyuwtZ26CwK9MnlZyxk4G+up+OgoICFGoCUK1mdyJ3N7UIYEyygisCS+t
 vnKSiOAWLz2eDbo+bM0uSWHMlSD4+mbVz7kLajWDqFtcfNOzvvb0b45PccBrj5895j4qdzSFzhK
 Ve7ApnA+/WI7OAlI3kUBZI6f6sYPzXj3q1yBSE68Z9G/H0YfwzT3cLXekIur5o2HMrT8qF7ADOO
 iuSg5XZLAm/ak+94FHnBpx0+vUlwhQB1a/QI35Ufqb/ejLLH7k6llNtthRZ3177TGeKyRYwagK7
 2apIsqRv+eGwYS7DjxjGznW+Np9qc20PbsjBzHAgkD+SInXO2yCNPC5sfxNoRpSEe4TH2By/+7j
 UOzszyUVbe+zWAxu+5Ctm1vct3v6gRQM3ts4U2p6QwipEHbVNfMmEt2WIg8fHnK5xNv7v6j3OAN
 LsYq7rASAAna17J4p5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130108
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

On Mon, Jul 6, 2026 at 2:45=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the OF node for dynamically allocated
> platform devices with the provided helper.
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

If not too late, feel free to add:

Acked-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  drivers/pmdomain/imx/gpc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index 42e50c9b4fb9ffb96a20a462d4eb5168942a893c..abca5f449a226fbae4213926e=
1395c413160c950 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -487,8 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev=
)
>                         domain->ipg_rate_mhz =3D ipg_rate_mhz;
>
>                         pd_pdev->dev.parent =3D &pdev->dev;
> -                       pd_pdev->dev.of_node =3D of_node_get(np);
> -                       pd_pdev->dev.fwnode =3D of_fwnode_handle(np);
> +                       platform_device_set_of_node(pd_pdev, np);
>
>                         ret =3D platform_device_add(pd_pdev);
>                         if (ret) {
>
> --
> 2.47.3
>
