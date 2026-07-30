Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4518C55164
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 198EF10EF5A;
	Thu, 30 Jul 2026 14:31:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mgj3dnWs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j2Brnss/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C06110EF58
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:31:08 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UDDO0o1062969
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JCT3EPO7gLLjh/8pAuKmI/lG
 uSDERijqki/K1oJAcNU=; b=Mgj3dnWsw42JT8wCEe7gC0WI0m0wu9ltMTFEzBqx
 cAVV1sX1YGzCvyt5oYGWXMEOh57YBzudwbAbemMddwEkTyaU+JHpLkz34sqEyOQO
 3ejldVR3fxiH1F44uSYVnueLQKjWVCDjjRU/3Anjgn8LfomDsBUMM0KufS5LVam+
 ekbDM4DwSQHmoG591C2HZzjNu4hnWIgy9zW3JoSoQxLNpRUW1Cd5dzwv+nPLl+gn
 EHCiA5lIpNhiO1H739gFU1XJPBtX46AVIWbWBzORlC0Fe8aUvRX8c4LFu5zc25aT
 qd/m4Rg4r3aP76j3MdokIfVmGfte9HijtCo0fx4MIHkbow==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr6yfrf7e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:31:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so246765285a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785421861; x=1786026661;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JCT3EPO7gLLjh/8pAuKmI/lGuSDERijqki/K1oJAcNU=;
 b=j2Brnss/dYjJLmbWH1Z7u0rs/7BPBSq8HJGa1PxJ4qg1WvRkzf/UVJpeK/K7CZtdJP
 EBiBPkcu/GfcoP1zOkC+PXJR7TmSZB08fCpqwoAAINCILFxQ6i9B7tjvbjlJoBD+7uK7
 ayeDclxThsNa409IONVWS8nWURCuaFHNEOyexiAsINePAbqtZBYoYeiIl4W3mRTvE+Qw
 hLtMG6uvlAFkuCMES2Sk5WoVlxLeLMN+Vf/vuadiJ3ELS4grFXNe5LI3C96g0hu9zYUC
 0BuK92L4kG3N2PiDu8xeZgETpZbi6zbY++0cfElbAdZBn31ep0GVBuIHRmkzx5rhOuKV
 Dymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785421861; x=1786026661;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JCT3EPO7gLLjh/8pAuKmI/lGuSDERijqki/K1oJAcNU=;
 b=DH4SZUaKBvG0u2y5tOWUYSPvdCP5EnQirzZyEsBFuxjrF98kkGsD7cFNHN/8AxzGvd
 IQSa6/pNfy0mUJTZrsrLRTxwPs93tT41xfDeqKfDr4L8vg42oqMtW7LViFfHoE5NAml7
 XTakFu5Y9e0aaE9AFJgMDBiMy2dpX8dNNM0OqbddHGP3xBrkdTAiGLWEk+7rENjbcthg
 cJ2XpyLytoXhPD/1hfxNUDGukEYCO8hIQo+AsFm/B8NamzN3xdByqGF0axxLfs5ue5CF
 uDRpG4EhaJf+vmjd0jMtbZXUogc/4rLrOKwY1PsGecIuDNUIhoMs6pB9iJC8v13mB9W0
 NhQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDyPX72qWLHSlQ067fntEAq79chRP+lCp4PLWedW81qTy8jWy5A4j2vD71mYmVoAjGyHjK685ZJr0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDoX1gh26OpGa/YbmnyovvldGNllFDdl3zhRzD9+WXOlhM+r5M
 7F+EtyEUiWMvCc+drx3vonDKaatBdA0KL7fQONz42BxF6MjfoiWqjuC5UATjSLfK6wOP+ZTFe6r
 KwUFOWIT/JGGF+XVMRoB79Gi3WaNWGbUuGnDLHw9iH4lDKiFSWqd9JoLhPG90pNtBHR+lG/U=
X-Gm-Gg: AR+sD10BIkqApTED/q9aJO7t3JxNmISj/JPpOyHOQMybFmNsZuSvBPpX0fve2AcYZMs
 cvreSBOqezr+0/447+OdM+1UVaRuQUh/clH6HnCezqd8g85EWWd5lAfn8LokE4G6iujD8gOSfez
 apPSi0Jy0iKlG2aFDvFFERNL4NNkE5FU+qzkBIHC+harGEJsD+ZoM6xUyAu2ORGCgl6e6UrYvmZ
 H//OLHRxbuzKrzMuE2gohJ+cD9A375vlcGQ5rmy0C2f7aFyiCXKcZGIwK8e+k3rr/kZU+bA44z4
 yQ/+B0/xiwglheq80T9g/fROtsOZJVuZ3X0yfzXIZ6OhAaT+M0Rrkb66TUGf93KJRhuMDpRa2ks
 ngMb+lPIB3YduCNyFB003MiT92R84mzd/mHCclELE3UTOsM6YkMZmlkAaEZoSHs1YTBt800Dz7r
 j6wMrtC/SJlpk9MQ==
X-Received: by 2002:ac8:5f07:0:b0:51c:7b12:1201 with SMTP id
 d75a77b69052e-52b386c7b4emr31713281cf.79.1785421861144; 
 Thu, 30 Jul 2026 07:31:01 -0700 (PDT)
X-Received: by 2002:ac8:5f07:0:b0:51c:7b12:1201 with SMTP id
 d75a77b69052e-52b386c7b4emr31712241cf.79.1785421860267; 
 Thu, 30 Jul 2026 07:31:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2db9c5196sm377549e87.56.2026.07.30.07.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 07:30:59 -0700 (PDT)
Date: Thu, 30 Jul 2026 17:30:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Joerg Roedel <jroedel@suse.de>, Russell King <linux@armlinux.org.uk>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/3] iommu/msm: track a context master per device and IOMMU
Message-ID: <ketiunovezpn76nxocpima27esjt66vve6tmqg3e4murz3yjga@pxl6kikpbk5l>
References: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
 <20260730-fix-qcom-smmu-v1-1-b12fa067804e@oss.qualcomm.com>
 <c77db81f-9fb8-4803-8efb-078b8cf70fab@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c77db81f-9fb8-4803-8efb-078b8cf70fab@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDExMCBTYWx0ZWRfXyI8xO7d+eTe1
 F/hOXW4uyq3BpnNPKulRqxHFBMw0tcBoSyxQL5/aDyNQteroOAZlhcRK4UayqmdqFdLjODiLbWL
 Jvv7msts9nkAElSUOtoCMgBL300F6n9dPQvGqKUBc2a8m2ZZWEWvcgi82N0wsnOcsjBuxsmVh2L
 fH+n4GNixFzbS5TUcamQTWeAMLtNEdKURK5IWvq/StBp+meZWMP2xrHwwek/DZDMb533iC8oS8+
 T+axVo8zndwLhd16PWLL5L5Qy3jyPOlIBoFxQnt4rLnhPe75i2tNbPiTxvPC3RnGt4dIkThVAGu
 P5woDbLjox/tqgS/6qZeoXAj8opwnTeQfULTjsFzFG88E4n24dXZVZa+2fYysGY9W5oQ8DyQZ50
 UDkp6j2gkjoE06GDdddzwx5Qid0P427cnraTer2I0h0zMm27ls1O3nWsaJ6M0q/KFkdHd8pb6o6
 4nQDbd24T2Zp6EEl9Og==
X-Proofpoint-GUID: WzNy4Q-Sin9W5TrTE1PCY7n7COrQsYTZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDExMCBTYWx0ZWRfXwI/74hCHYE/L
 ytqfjJNr1D1JPUjr/9PA2MRDpncARB1CB+gRTx94xbx5Gc9k0QwomA6E4SgkqrDEpeEeRw4XjxX
 BPnpa2k1Fuelp5TeFIzFR9t/vL9XpJM=
X-Authority-Analysis: v=2.4 cv=Tv3WQjXh c=1 sm=1 tr=0 ts=6a6b602a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=6Z1frLYTuOUDIWW9GX8A:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: WzNy4Q-Sin9W5TrTE1PCY7n7COrQsYTZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300110
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

On Thu, Jul 30, 2026 at 03:57:42PM +0200, Konrad Dybcio wrote:
> On 7/30/26 3:29 PM, Dmitry Baryshkov wrote:
> > insert_iommu_master() decided whether to allocate a struct
> > msm_iommu_ctx_dev by testing whether the IOMMU's ctx_list was empty,
> > caching the result in dev_iommu_priv, then unconditionally dereferenced
> > the master:
> 
> [...]
> 
> > -			dev_warn(dev, "Stream ID 0x%x repeated; ignoring\n",
> > -				 sid);
> > +			dev_dbg(dev, "Stream ID 0x%x repeated; ignoring\n",
> > +				sid);
> 
> Is this intentionally part of the patch?

It can be dropped, yes.

-- 
With best wishes
Dmitry
