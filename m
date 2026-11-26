Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79AF606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P1LCYAuM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X7l0Tgnp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E9B610E3AD;
	Thu, 26 Nov 2026 11:05:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B9B710E3AD
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:05:19 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQAYJ93508994
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g1svp5E9pb1rvrFjE3ldylGmmn2srl47JCoHJgVCeZs=; b=P1LCYAuMr/D5qPTC
 qvoMVcOhInukkngJQPbRRoVLIxCrm3Cbfltg0ixbMdjOrOCz28lnsbK/FQbX9Kxo
 BkB6bDX3zRnt8Lih15T2VcTNv3NsYAZmdBNcGIxrJ9waXYUlSRR2c5ItayhUE+Lj
 UIJqi1GcDJuTJV8n5mrLlU/qf/cOXHqVrbFPCDN4b0Cqz9iwZUQbDA+S+IHfUpR7
 ZaGPJrzmcNTomoKTKw6DtX4u+/Ex32UNVMKqo5Hvrp3sL161tdjQ+yWKRBUIzIeB
 VPjhRhXeaJs2curePdUvH8qZN14pakXXbheUUye90cMh2duVMtLEbyyacpM8Tti8
 AevJyw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne0reg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:05:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3adeba76cadso4684503a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 03:05:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795691117; cv=none;
 d=google.com; s=arc-20260327;
 b=JCYpyGaahmVi7So/rQkKN5tz8jEhNjp262riRchmdWe2mfcObkstynf0lYjs7IMafy
 04ApJSpUKIHhzTL6haiRLNGR7mSbe+/5F4C3RspaJBKF/nL+eSWHUn5k8RSliwYPZpxK
 3AoikIfTs3d7hZHY1rZ5aTdH5Bz3SeaanVwLISZ+mGPB2Fs21UatiVR419KN344QrFPc
 WE3sj6d0nxilTOVK2jDc0ZVQplkVurS9hOj8NKbSAzcR9Wsa5enH4PSujsrRPypwYW//
 /vlm706Mn22GNPonahcLCFRX81ioFVcOJEbOo8x9Joqb2QwyGdcP++sJgk1BxtRDF7Pd
 gTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=g1svp5E9pb1rvrFjE3ldylGmmn2srl47JCoHJgVCeZs=;
 fh=fGrpK3RX73RJ2F3baSE2v/MXDFIvaK2+7yWhpps1H08=;
 b=n9IPQY6GDzth8hHer5N5tp8PKvNdCZt17x6TxNpWWhgZFDySeUZAO0AXJS7UCHpNcB
 FO8NWB/lNsb46nNgkDYDi94pwkYYYfHUkIh8ugSId01ZZaSZHBWI0W4Wfzg/eaxtu0fu
 7JF98yXNovP2lD7nNhyMFeGtOUkjafCvtqP4WXifKrTpLaT8d3cbqSSgWK/Y14lGjolj
 ZF190I39U5gob8unDx3/aM0sjyqYqW4ly8RhoxNTjVCm8wOJJRocJ2uc29at669SM4mf
 lvWdPUZCQRLrHlBOuvpQS/mmersDvBp+G0PWVu94iO00i8gEa2S+N0KtHJun8JJa6tUD
 FfVA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795691117; x=1796295917;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g1svp5E9pb1rvrFjE3ldylGmmn2srl47JCoHJgVCeZs=;
 b=X7l0TgnpFXUm7fdb8hqkoPIBEgX9Ts4KKY4ga0BD3zI3JvLiKwWIpkgUCzFUco6BGd
 0clDzVEgC7KRntHDbzRHmVEqF4X2y4RvcjM66soIRSKAhQq9AgLyII+9HTgOG7Tmxkm7
 g3dYsEuXESIUzkeOuVPnOVpx9Q6ji6uWgF6qMtlse5HzHuAeF825XorzgvlcwLRN9cbw
 66bMIeTe2ZEpuupXfv5ChAFqufzsQl0iHryV8W6UvOcaddFmKOGs0euVkq3chIOZf5/H
 dirZMYNEPGJmsuHoUifLv2UwAAgauBt5vlGm1SZlLcraH0F6Kg+nwZr+uG1cp18S47xg
 q1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795691117; x=1796295917;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g1svp5E9pb1rvrFjE3ldylGmmn2srl47JCoHJgVCeZs=;
 b=P3fXzEEaqEVMsYk3px+sSlTxI+IVMkoWtPNt7GHdTyoKjB+vUWjgr7nifD7Z72CFhl
 TQ+qTTT8v3DVZADWeF+ovW0KJS1DUUvjVHQ56mZBNdxkAnVNa34A8N+rwhTdvxEpTweb
 bQgEOMnHMewLjdA3+CTJFLc45RJxnpbghkBQPCRlnui9T9UMJ7/m/yxCoL0rN59KOcNL
 sdVOUumdi3rYhYBHHbJjJ2VB33RpuA2hvmxKELFAQlcnF0Q/1paqoltsJouqM+VjPNnK
 5+R19qCpvW7qI50Fu1WRjPQyZw6i9x7CklS5iFycl8hsCR7DjXW7+cuvTTNVBFgmdcN+
 WzYQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGrJRyQYMruIbw1Q3jasUBm8fdU/xWm59idyNYCMmM/7boTFOZXnN1axKor2MeVRPNEmdxWKvHKxQU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z++GkTZ4mcfSrm1jHNJaN2yXq4pen5YBRQIn6ANb70CS3ca3x3I
 qAe39o3nq+qp/U3QkSls6uaOwFUM9Z69R2N5sVwL/K+8u6yhN+Hy4k3m49tLRXnxKvJTrtRvn5s
 Ps5ZO1hnfDv17PBtTbEBxA3CdzJNaxkS8lg9QVT7DO7Ap4Di4bldhPj0UMtBvcpBjw4k2mG/2dL
 lACpwkD/rW1gncGrYfe/gA781X3DPDBaD9ywylNGFAf8KRXg==
X-Gm-Gg: AZFdTZfIRToZNiw/7tZdATie4aPWyHpvxFFVoGGUxiMHCpmdqSXAEwmTaoBPL1qpo+K
 vpZrb6vLmjOB2oSR5kx7vP8xnoGPaI0ok77pteQNPdZzeqbDyBsH3e1zkufJ0wqXsRrkA+pyVH1
 4NBMJOae+9BJ1C1739WisjC1jN/p9EsGoNoI5gy2LdV0708NOlMEa1JK6siQ==
X-Received: by 2002:a17:90a:d2cf:b0:3b3:b595:2473 with SMTP id
 98e67ed59e1d1-3b41c906b61mr18544090a91.24.1795691116575; 
 Thu, 26 Nov 2026 03:05:16 -0800 (PST)
X-Received: by 2002:a17:90a:d2cf:b0:3b3:b595:2473 with SMTP id
 98e67ed59e1d1-3b41c906b61mr18544043a91.24.1795691115988; Thu, 26 Nov 2026
 03:05:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117173738.1073856-1-Frank.Li@oss.nxp.com>
 <20261117173738.1073856-2-Frank.Li@oss.nxp.com>
 <CAPx+jO9RwkpSKwq6vq00uoXK-mcovJ2LMH7b_ByRnxOUj8nH8w@mail.gmail.com>
 <CAJZ5v0jsnLjEBxa1R4Q3hZLZKrCUW0xSE9SqLB8bd4tNAhXTAQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jsnLjEBxa1R4Q3hZLZKrCUW0xSE9SqLB8bd4tNAhXTAQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 12:05:02 +0100
X-Gm-Features: Aa3M54r_rMhLGHc1vqQ3FXriLYRwoLb-Xyx7xbWcsA8f-DpP_bkxDUBWaFpBhbQ
Message-ID: <CAPx+jO9JYTygL7F4nc9zb=iOmeKfdpa6-_QBOvAmMN9fp6HfwA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PM: runtime: fix stub pm_runtime_get_if_in_use()
 for !CONFIG_PM
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Frank.Li@oss.nxp.com, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulfh@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, Hans de Goede <hansg@kernel.org>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
 Tomasz Figa <tfiga@chromium.org>, Marek Vasut <marex@denx.de>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil@kernel.org>,
 "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support:Keyword:mediatek"
 <linux-arm-kernel@lists.infradead.org>, 
 "moderated list:ARM/Mediatek SoC support:Keyword:mediatek"
 <linux-mediatek@lists.infradead.org>, 
 "open list:ARM/Rockchip SoC support:Keyword:b[Rr]ock[Cc]hipb"
 <linux-rockchip@lists.infradead.org>, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dafna Hirschfeld <dafna@fastmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 dri-devel@lists.freedesktop.org, imagination@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b08126d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8
 a=QyXUC8HyAAAA:8 a=GFqr32JmAAAA:8 a=pGLkceISAAAA:8 a=r_1tXGB3AAAA:8
 a=iox4zFpeAAAA:8 a=7CQSdrXTAAAA:8 a=mpaa-ttXAAAA:8 a=QX4gbG5DAAAA:8
 a=ZLGELXoPAAAA:8 a=P1BnusSwAAAA:8 a=zd2uoN0lAAAA:8 a=e5mUnYsNAAAA:8
 a=JfrnYn6hAAAA:8 a=foHCeV_ZAAAA:8 a=x6yKa4QoHz4R4KwlW4MA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=ST-jHhOKWsTCqRlWije3:22 a=f02Ha7HRcztGgdyUxOxW:22
 a=t8nPyN_e6usw4ciXM-Pk:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=AbAUZ8qAyYyZVLSsDulk:22 a=CFiPc5v16LZhaT-MVE1c:22 a=D0XLA9XvdZm18NrgonBM:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=1CNFftbPRP8L7MoqJWF3:22 a=h8a9FgHX5U4dIE3jaWyr:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0MiBTYWx0ZWRfX8bdZNCbF2Ny9
 XS3LMM3ggk2ztPsAiHOrR6oXfeRYvOtds8nwWBVjxqWyDggNpKXE77XgOUTICiH7nHui5atpSXy
 gLixQzx+ibAcyNwFR+wiv33iDgeZekHaMxf4Vp5uHptS/cUIMq8HuxcESeSn0DD1ye8AH8CDc93
 isCT7HTVBEHvRwskQTmE4KCQuUSZMEgJRJWMIG1lilE1j16r7UJ+RiH+DC2tmwdspaW9W4T/L0+
 QrhQ4EAfO0k6s78ucCw8WyVxO961r9HbUWqOEwZEYFiCFhWEQxkiAaka9JefGKEPWRkXZ1SaS/F
 2T1CCEvjYxKlgfDwtt/GeAtviAWo9EJ3jml8A4T98y2fjJ7Hd1nsxx0pMqLvxEJd/vUwLmJy1Wp
 RYLxqenmTaWd3V6k0GJ46cgiPjUkrzN9mChshFbjcKu40sRpKT5A0rXdytMEjr2cI6Cq+DQkGy3
 tN3PiNlNIpmc1cWTm0w==
X-Proofpoint-GUID: tlObTdYoYslrcLCUOMmZZJ1XKhDq98JW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0MiBTYWx0ZWRfXz5Zl/g2Sb7Gc
 NLEsLjDEZHeRuTUby9LwAYGPO9GbF0MJiXiJnWxp94BUfwbzNlxRxvb0xsHIosGhCQLClbUVvRI
 faypJ0n/Ay0JhhOBJ3bdUqn/dzL3ZDU=
X-Proofpoint-ORIG-GUID: tlObTdYoYslrcLCUOMmZZJ1XKhDq98JW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260042
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

On Wed, Nov 25, 2026 at 4:53=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Wed, Nov 25, 2026 at 4:07=E2=80=AFPM Ulf Hansson
> <ulf.hansson@oss.qualcomm.com> wrote:
> >
> > On Tue, Nov 17, 2026 at 6:38=E2=80=AFPM <Frank.Li@oss.nxp.com> wrote:
> > >
> > > From: Frank Li <Frank.Li@nxp.com>
> > >
> > > The stub for pm_runtime_get_if_in_use() under !CONFIG_PM currently
> > > returns -EINVAL.  The real implementation returns:
> > >   1  - device is active and its usage counter is non-zero (bumped)
> > >   0  - device is not in use or not active (counter not bumped)
> > >  -EINVAL - runtime PM disabled for this device
> > >
> > > When CONFIG_PM is not set every device is permanently "active" and
> > > always considered "in use", so the stub must return 1, mirroring
> > > __pm_runtime_resume() which already returns 1 in the same build.
> > >
> > > Returning -EINVAL breaks callers that test the return value with
> > > comparisons other than "!=3D 0 / =3D=3D 0":
> > >
> > > drivers/gpu/drm/i915/intel_runtime_pm.c:
> > >   if (intel_runtime_pm_get_if_in_use(rpm))
> > >   which wraps to: ret =3D pm_runtime_get_if_in_use(); return ret > 0;
> > >   With -EINVAL the wrapper returns false, causing an incorrect error
> > >   path in the GT fence revocation code.
> > >
> > > drivers/gpu/drm/xe/xe_pm.c:
> > >   if (pm_runtime_get_if_in_use(xe->drm.dev) > 0)
> > >   With -EINVAL the condition is false; xe_pm_runtime_get_if_in_use()
> > >   returns false, so callers believe the device is not usable.
> > >
> > > drivers/gpu/drm/gma500/power.c:
> > >   return pm_runtime_get_if_in_use(dev) =3D=3D 1;
> > >   -EINVAL !=3D 1, so the helper always returns false when !CONFIG_PM.
> > >
> > > drivers/gpu/drm/imagination/pvr_power.c:
> > >   if (pm_runtime_get_if_in_use(...) <=3D 0)
> > >   -EINVAL <=3D 0 is true, so the driver always takes the "requeue" er=
ror
> > >   path instead of proceeding with the active device.
> > >
> > > sound/soc/sof/debug.c:
> > >   if (pm_runtime_get_if_in_use(sdev->dev) =3D=3D 1)
> > >   -EINVAL !=3D 1, so d3_prevented is never set, corrupting exception
> > >   debug accounting.
> > >
> > > drivers/iommu/mtk_iommu.c:
> > >   if (pm_runtime_get_if_in_use(dom->plat_dev->dev) <=3D 0)
> > >   -EINVAL <=3D 0 skips the TLB flush, leaving stale IOMMU mappings.
> > >
> > > drivers/iommu/rockchip-iommu.c:
> > >   Three call sites use WARN_ON_ONCE(err < 0) or similar patterns.
> > >   -EINVAL < 0 triggers a spurious WARNING on every call.
> > >
> > > drivers/media/i2c/isl7998x.c:
> > >   if (pm_runtime_get_if_in_use(dev) <=3D 0)  (two call sites)
> > >   -EINVAL <=3D 0 causes the driver to always skip register programmin=
g
> > >   when !CONFIG_PM.
> > >
> > > drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c:
> > >   if (pm_runtime_get_if_in_use(dev) <=3D 0)  (two call sites)
> > >   -EINVAL <=3D 0 prevents any debug statistics from being collected.
> > >
> > > Fixes: a436b6a19f57 ("PM / runtime: Add new helper for conditional us=
age count incrementation")
> > > Fixes: 3b85b7bcccf4 ("drm/xe: Fix display runtime_pm handling")
> > > Fixes: 672c473576ca ("drm/gma500: Rewrite power management code")
> > > Fixes: b30289e7fa92 ("ASoC: SOF: Fix runtime pm usage counter balance=
 after fw exception")
> > > Fixes: c0b57581b73b ("iommu/mediatek: Add power-domain operation")
> > > Fixes: 51ef2be546e2 ("media: i2c: isl7998x: Add driver for Intersil I=
SL7998x")
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Change in v3
> > > - drop tag: cbb819c363c5 ("media: rkisp1: debug: Collect input status=
 by sampling ISP_FLAGS_SHD")
> > > selected PM at arch config
> > > - drop tag: 0f181d3cf7d9 ("iommu/rockchip: Add runtime PM support")
> > > selected PM at arch config
> > > - drop tag: 9d58aa46291d ("drm/i915: Fix the GT fence revocation runt=
ime PM logic")
> > > guard by CONFIG_PM
> > > - drop tag 727538a4bbff ("drm/imagination: Implement power management=
")
> > > depend on PM
> > > `
> > > Change in v2
> > > - new patches.
> > >
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: linux-pm@vger.kernel.org
> > > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>
> > > Cc: Simona Vetter <simona@ffwll.ch>
> > > Cc: David Airlie <airlied@gmail.com>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> > > Cc: Alessio Belle <alessio.belle@imgtec.com>
> > > Cc: Luigi Santivetti <luigi.santivetti@imgtec.com>
> > > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: Jaroslav Kysela <perex@perex.cz>
> > > Cc: Takashi Iwai <tiwai@suse.com>
> > > Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
> > > Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > > Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: Yong Wu <yong.wu@mediatek.com>
> > > Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.c=
om>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > > Cc: Dafna Hirschfeld <dafna@fastmail.com>
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: Michael Tretter <m.tretter@pengutronix.de>
> > > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: imagination@lists.freedesktop.org
> > > Cc: intel-gfx@lists.freedesktop.org
> > > Cc: intel-xe@lists.freedesktop.org
> > > Cc: iommu@lists.linux.dev
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-mediatek@lists.infradead.org
> > > Cc: linux-media@vger.kernel.org
> > > Cc: linux-rockchip@lists.infradead.org
> > > Cc: linux-sound@vger.kernel.org
> > > Cc: sound-open-firmware@alsa-project.org
> > > Cc: imx@lists.linux.dev
> > > ---
> > >  include/linux/pm_runtime.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > > index de9e7518ecef2..1d983fe55a16a 100644
> > > --- a/include/linux/pm_runtime.h
> > > +++ b/include/linux/pm_runtime.h
> > > @@ -276,7 +276,7 @@ static inline int pm_schedule_suspend(struct devi=
ce *dev, unsigned int delay)
> > >  }
> > >  static inline int pm_runtime_get_if_in_use(struct device *dev)
> > >  {
> > > -       return -EINVAL;
> > > +       return 1;
> >
> > This should be return 0, as we did not bump the usage count.
>
> This is kind of moot because there is no usage counter.
>
> However, the caller may always take the opportunistic "in use" path
> because there are no potential costs related to it.

Of course, for the !CONFIG_PM case that makes sense.

Please add:

Reviewed-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe
