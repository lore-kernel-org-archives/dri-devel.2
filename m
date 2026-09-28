Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0633CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15B6110E514;
	Mon, 28 Sep 2026 11:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ce7c9O47";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FB/pUQKR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EF5D10E092
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 11:21:54 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SBBCXC4117020
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 11:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=vEol6TW939SVBwS2LYfyS9kRHzntWvKw1rsJmaCbjOQ=; b=ce
 7c9O47R9GFrf2ufQeGLAslfvXpcTqCG+8Hf7/gz0tgFPwUvUitVHwn2oG2jcRdVX
 P1yBiO91/Co8apRbEwazCRUPcXwmK6ohEvpMijxp/dzEg3r2EXLB5MKVYyDiWb16
 0kszagorsBZDn/qVYBsknXcitxsksB2PK5Rj0WCz8n9oNTIM9aIxs/leeOCOnPcK
 clzHlmw0xoyYrXmCKkggJZsN1tBvBu2J6Ye08K5HJ68WzwVJUyjveY/9mOjV6hKb
 NZcxyUsBdrvhYK8fID8WeCx6wZB7I4TBCwZCt/e/mcf+4Ufb7NWS5Fxhyrx2kwBD
 AoRJBJnrPHzdXRETckZg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77jwrj1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 11:21:53 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-81dc8e2a180so306601a34.3
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 04:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790594513; cv=none;
 d=google.com; s=arc-20260327;
 b=o2WhVb3w7xT8NojH9TZIcc3NNbDv+zysootMuZBaLTEDNRxUEUu38kByD2aBP6sqxJ
 2AOjqcs0D8x+QNIHpBr9Hir298tLwfbvbHYD+4YVqlTNP8Rf26JRAOy8ET3hgOCmtJBV
 aAi819ML4HwEWcAs5c4Ibx5D7MKwtzqvM9Ly/ZpKWQePFNe0xeoIjSbbn6NleYf9GyhI
 sN6oCqQwiN+I/vtM6u9amIKgS/RzGMesRnAr1zxGCp8pSw5IzKN9K5IpHbWkl4LTuy6x
 J4i0XbWQbzygYTghQfyMeazSqU1kcKk0/pQKYq39jyG6SukwIzHmOIFsHur5KdAE2s+v
 dYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=vEol6TW939SVBwS2LYfyS9kRHzntWvKw1rsJmaCbjOQ=;
 fh=lZ1BiV6DuUUOK5wrTx3ra60DXERHVBQyqY+ExxffHWE=;
 b=N6CG6t5PB1C4+Czd18ZF+KIn5BGzXvQ//Yi6F+QO1LYpdav0d/iNFB1iEM/Z7IaJWf
 psa99EIvkewCaEzx3kpucdoJ0DZnH34AlZoXtwybi2zmgNmGXbws+JXGxo0IPEya9SI+
 f1KEjRMVR65+tdO0OV/yaL7OR5BpmkfI4FDUq/1kzV9C2Uv9bnOImHc6WSrEIKUd2QuB
 GQBT/bHw2eL896UWgFk71lVmbzGLXQgvvNGPdTWmbLU3KT0OBCIS9VsyIBUcRt7AXgJF
 dLfkSvyb5Bap6tMf6F0r6s8LSKmInQ5acSeA/E3YK1yLnVXYGOcw0yXyy6bGxS58kQMv
 0ktw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790594513; x=1791199313;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vEol6TW939SVBwS2LYfyS9kRHzntWvKw1rsJmaCbjOQ=;
 b=FB/pUQKRPwny7lBUsQccV76qvzitEBWy4jVWvo2AekPuVwmZ7fGnBV7TqB5TWpW7Lf
 izv84hzJOWIW5lB4glIVnSfo9DDGvL11K9AtOqVHwStQqcKYU6U6l3jPeOAhYDlcfOAT
 yTgQljvmfw8UhCHCOz02G0j4CBK+89bOJeo8CrHDcPPwxGwIs9vglxI6tGrTb1YyJSph
 TZfO0UXOhTJ7+IDLCoJ1zm1yPgKSLbtZdmNEMOKptHtNXA4T2mg05VL9Rc6UdiPQv7Pp
 ++7wZfjD+0Hyr4ca/Bu0g+xpUZi65qR3YuZ8AWuSePRU23ejkhkLM95Y/X56jT7pR4Ux
 jdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790594513; x=1791199313;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vEol6TW939SVBwS2LYfyS9kRHzntWvKw1rsJmaCbjOQ=;
 b=BwF0U+9OMV15PJFfBNmHa09KMaLhH86/Nzu/ICdAJ0Jt7PuUuYlWa1ew2TJbZW4+S7
 r6bIkn3ADSWuoc1gchQJLQmxd9G/HohZVK3EDGfombQZoPJtyyOerFy+x/Bv+gnQolrY
 X1+q8WiGWHJL0Ms3LAqvcXJ5kKjVld4W7pgTMxfl/xB9fnK7uYVLKtXrwY4SXTUJG5kx
 KTZz86zcDf3WBH4a+JdKCgD2ZYhA3nBkKcK7PMU3xymVWy/gE83WCWJAhtBqvsG/1rwR
 Xjh6+VvbhmWsmIWRGYfnrrvtQ03Pc9bKTDv7ohur9w6BkiS533WcghRtvtXRemf2MxeR
 wA2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtqFXBqx4PQ2NMpD+EJ5KsJF/3goAvsArHrhSM9jf4wiJxJtwq0WM4wuFD+NTbQ5iLXyzgspZ0FCI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lew/9U1Dkk+qftG0+AqdFv5urx2twzCTYE55zT8TGT+aM7AsMY
 HnErb/CkR+dbN7HueCE0f6bRq6Ei19xUnYXGl5j/UYiiEB8qE8nCG+pjaPjh4w6BHUnFn1D92ad
 wCMjMk59FUl4GRjWET0SaS4jXbwwqulbt1uTAVP1nJfVK0I5NSxduXSb1pKyjmwrDWo0/e7kzDW
 ZHktsBaIp2t8JSAcI8al6BBkz1kfwkGiPmumBrp+NByUqFCA==
X-Gm-Gg: AYBFou3327ymXVt/dmRDPZUelRz0pTHUdRlJmJ71+3i23y2bhnimsmhE28miTqOqvRx
 NKFUCPb+UHjq85vwFPm8+UR4LPywMgYqtlbjIYemC09FZYlZez6snrbHQ3bz/WoAEwAciGX/4l3
 rqVAOIZqbAr9FWxEEm3hrzdYhjlszZ5E4r4fzYXUJtU22LPHiXkZwXE8fr
X-Received: by 2002:a05:6820:859b:10b0:6d7:4142:8b78 with SMTP id
 006d021491bc7-6d741428fe0mr3459532eaf.6.1790594512860; 
 Mon, 28 Sep 2026 04:21:52 -0700 (PDT)
X-Received: by 2002:a05:6820:859b:10b0:6d7:4142:8b78 with SMTP id
 006d021491bc7-6d741428fe0mr3459516eaf.6.1790594512410; Mon, 28 Sep 2026
 04:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260926022026.10539-1-liujianfeng1994@gmail.com>
 <17bf71c6-2442-4eaa-847d-29ef625870bd@amd.com>
 <CACSVV02WCQwQy9BpUUqziQTtKV7QyJruiM+iTiLE_SEVKtpVNQ@mail.gmail.com>
 <50a9c1f1-6889-4bd5-b4f7-0500d30d3dd9@amd.com>
In-Reply-To: <50a9c1f1-6889-4bd5-b4f7-0500d30d3dd9@amd.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 04:21:41 -0700
X-Gm-Features: AclHuK_NwDQDsbrMuZGC8NlkccTPkeI6CyUHvdugPvoIb7ACoIyYXlrPqpyu7j4
Message-ID: <CACSVV02BPHGeGFo0vs8-Q2JvcvQ_gw_xe4kZj_nuzk8n6sW7kg@mail.gmail.com>
Subject: Re: [PATCH] Revert "dma-buf: Make DMABUF_DEBUG default to y on
 DEBUG_KERNEL kernels"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 "Bryan O'Donoghue" <bod.linux@nxsw.ie>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Karl Mehltretter <kmehltretter@gmail.com>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NSBTYWx0ZWRfXyg4iEHZ3fY/D
 G5h63G4JQph1OVeKpvuEmM2ukGbU3kjOE5EopFWQrP1xmb5k/bZWULNj0n042+25QOlfUbeBrLO
 wAMEAskd0Qu2lqaqvr7eKGEsOHah+Y0=
X-Proofpoint-GUID: 2z92B8KCJoj6DmIoXZTP3TSANMm5WRaE
X-Proofpoint-ORIG-GUID: 2z92B8KCJoj6DmIoXZTP3TSANMm5WRaE
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6aba4dd1 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=zd2uoN0lAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=jDRU7hdYw16n41J9DU8A:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NSBTYWx0ZWRfX3Ayk3pV1upu0
 xtHVx99Z+ESEcBpPLLPy7uQ2JLnKydSleWHCzHKZHdW8JgLk2E8c3A5n4apBpLi7ju2EzyJwQvi
 kPNunF3roELWYvEOxgHJxECwOTMRdaVadM88Rf1l3hLxKwToIlPhcfiqS/ZDFX1AteXG8i2DbQ4
 j4BW60BOfqNwqiAzbwSrYDSvLG53AHcwO20EJhOOfCaKrJA61MgC0LwV8NFreT7Kq7npeOWencV
 67rXRCII3laaoMDRWUpxm2LDm/14R2XUIDPysHipjtHMw1O2S5Df3mcKoeWW773l3es6WoMP4Sx
 cMtx/RLvfg/x3N+av+hthE1woN6ddUan91vopLbfgU/eDob+8yiZt1zIbLze4sSlN4TfOixTzb3
 GT34n1/BlmHtsQxpZYaY9Mb8tVHWp+p/mF8miLnjwj6T28Wt/IA7pRV35guMW2m/3qV8uAcx9mi
 FX6g4Us2nyz5mob7qsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280045
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, Sep 28, 2026 at 3:48=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 9/28/26 12:36, Rob Clark wrote:
> > On Mon, Sep 28, 2026 at 1:19=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 9/26/26 04:20, Jianfeng Liu wrote:
> >>> That commit fixed a dangling reference in the DMABUF_DEBUG default
> >>> and thereby enabled the option - and with it the page-stripping
> >>> sg_table wrapper that dma_buf_map_attachment() hands to importers -
> >>> on every kernel with DEBUG_KERNEL=3Dy, i.e. virtually every distro
> >>> kernel.
> >>>
> >>> drm/msm is broken by the wrapper.  Both of msm's map paths consume
> >>> sg->length and sg_phys() of the attachment sg_table:
> >>> msm_iommu_pagetable_map() for the per-process GPU pagetables, and
> >>> iommu_map_sg() (via iommu_map_sgtable()) for scanout.  The wrapper
> >>> zeroes sg->length and strips the page pointers, so mappings of
> >>> imported dma-bufs silently map nothing, and userspace observes
> >>> arm-smmu translation faults from UCHE, e.g. during hardware video
> >>> decode (clapper, chromium) on Adreno systems:
> >>>
> >>>   gpu fault: ttbr0=3D000000088a889000 iova=3D000000010741c000 dir=3DR=
EAD
> >>>   type=3DTRANSLATION source=3DUCHE
> >>>
> >>> Bisected on a Snapdragon X1E78100 laptop as v7.3-rc3 good,
> >>> v7.3-rc4 bad, culprit 143755bdabaa9.
> >>>
> >>> Switching msm to sg_dma_address()/sg_dma_len() is not a trivial fix
> >>> either: those fields are only valid for sg_tables that msm has
> >>> dma-mapped itself, which native non-MSM_BO_WC objects' sg_tables
> >>> are not, so the conversion needs more work.  The msm maintainer has
> >>> therefore requested restoring the previous default for v7.3, to be
> >>> revisited once msm no longer consumes struct page and sg->length of
> >>> imported sg_tables.
> >>
> >> Yeah as I said before the problematic part is MSM here. We have enforc=
ed correct driver behavior for over 5 years now when that option is enabled=
.
> >
> > The problem is bigger than MSM here
>
> Well, so far I have only heard about MSM.
>
> But yes I mean the config option is doing exactly what it is supposed to =
do, pointing out when driver need some work to get this fixed.

It served its purpose, to expose some bigger issues.. but sadly those
are beyond just msm and not something that can be fixed quickly

> I also agree that we shouldn't have allowed driver to touch that stuff in=
 the first place and better document how to do things but yeah I can't chan=
ge the past I can only try to fix it now.
>
> >> What we can do is to mark MSM as broken and/or give a warning in MSM w=
hen DMABUF_DEBUG is enabled and you try to import a DMA-buf.
> >
> > sorry, no, we can't mark MSM as broken.. we can mark DMABUF_DEBUG as BR=
OKEN
>
> As I wrote the debug functionality to enforce not using struct pages has =
been around for over 5 years now, it was just not enabled by default.
>
> What I can offer is to set it to default N for another few month to give =
you more time to fix things.

If it is disabled by default in distro kernels, that sounds fine.
I've cleaned up the remaining use of pages in msm (which were not load
bearing, but I should have done before to remove use of
drm_prime_sg_to_page_array()), but the problems extend further and is
a bit complicated because the hw uses SSMU in a way that dma-mapping
doesn't consider very well.

BR,
-R


> Regards,
> Christian.
>
> >
> > BR,
> > -R
> >
> >> But making the check not default to enable on debug kernels is not an =
option. This check here is exactly to point out broken drivers and you can =
manually disable it.
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Link: https://lore.kernel.org/linux-arm-msm/20260923074256.9357-1-liu=
jianfeng1994@gmail.com/
> >>> Suggested-by: Rob Clark <robin.clark@oss.qualcomm.com>
> >>> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> >>> Cc: Karl Mehltretter <kmehltretter@gmail.com>
> >>>
> >>> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> >>> ---
> >>>
> >>>  drivers/dma-buf/Kconfig | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> >>> index e4f078a326a41..7efc0f0d07126 100644
> >>> --- a/drivers/dma-buf/Kconfig
> >>> +++ b/drivers/dma-buf/Kconfig
> >>> @@ -43,7 +43,7 @@ config UDMABUF
> >>>  config DMABUF_DEBUG
> >>>       bool "DMA-BUF debug checks"
> >>>       depends on DMA_SHARED_BUFFER
> >>> -     default y if DEBUG_KERNEL
> >>> +     default y if DEBUG
> >>>       help
> >>>         This option enables additional checks for DMA-BUF importers a=
nd
> >>>         exporters. Specifically it validates that importers do not pe=
ek at the
> >>> ---
> >>> base-commit: 93f51579e7df248780214094418f205253383cc5
> >>> branch: revert-dmabuf-debug-for-7.3
> >>>
> >>
>
