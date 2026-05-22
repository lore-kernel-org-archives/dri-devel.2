Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A80CCD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 11:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA62E10F570;
	Fri, 22 May 2026 11:56:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="geBNzBf0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cClSuTRC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9656510F570
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:56:50 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M98iH81816103
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BfxQWgFxKuSlI+XcJxtqMogzPioT1S44n+WuIdPEiqo=; b=geBNzBf05MTME0eV
 qYAswt1xooJzuN4vo9X+7HlQnTb9BsoYYDgbxoxM17UERtEX/twUAVJeUikkW05t
 xYeJgllqRyn+KJW8/C7nlOelTwErYv5l8YZrtVHNfI6NYyTebn4lVR7iNi0nKXLN
 4ZdBxGTUk3Bt7eDkhWtfscUrrVMKWrCDJdToDHu1xm32CmC+DqWgFaMdQqVHtclE
 wWMZ9lFcQeAQckvbuXBLObD+rfxCdH9XeaHGKBFEXwh56kX4hCV1qBMPqGwYAUD5
 CgGK1pSvjHPO9fyWuL9ZpfVFTbw9nSUDrO10zBBjcqIlD3kv9EAecg17Ge/7Pyy9
 HNU6qw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrm1thr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:56:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ba3245a43dso77882565ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 04:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779451009; cv=none;
 d=google.com; s=arc-20240605;
 b=d7vaqAVy8Rk7qZh69qoe1KRVi9oTb8F5XZbhM4cg2CHrq+AgCDKtL3XNv3QlRQM4us
 lWY6fQIipKivkH0+nz82N2QeAh9DI4NNYmnALTfTcbUnHeORANhq6M7IS5ccBi1wJaNw
 dSoQvLuz8PPwEfk7TDct+v0wePSxKzTaqTZ5zImxrQ+qpO35vnlESkvhCFmW6UXZDWTo
 IlbFGEItgAtFulhrTICAi/0vOZmk/LqXdC393eW9Moyll+Rru7gkGiCAK/05NN4jyuvt
 9nkrse+P2f53iTcd26VE2XHe8jqI/awI1z3OZj/RHBjLAop6i7G4rmbnLYy4qPpTf5rl
 6+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BfxQWgFxKuSlI+XcJxtqMogzPioT1S44n+WuIdPEiqo=;
 fh=ykTbtCcUIQ3UpxQ2TyWP9JOfV8mbQF/lBkM+BPQ4vjA=;
 b=OGDIj3XBlgHUaOoe5YeGiDPOfhdqnrR+mVlOv5qRQcTeKvEElScEXqG9Y9lyonzd+v
 xgn867uw4jIBf95Hdt91c4UnRYNkEFt2dGi5LbtYxrsyRzuKK3qfBNXj/GH37AFypcKv
 FmGPZO8RbwHExQnTJ8JMTlKEDT78ZlVEntmZmxFqz4Nnr02JVycGvC/xzPYO/J9HIOHk
 BQ8Ob67l/jSjCK0giawBGv6bLQXUCO1c670kwU2HMIUND8PDNP9xhPK/bayR1iGqmD1O
 9vKhV7cM395/GZ2KpIfi9QSEbY5mLaTmUCVBDGnPWLrge0ykrM6u/ZimDGg5wI0uqrjA
 tS0w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779451009; x=1780055809;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BfxQWgFxKuSlI+XcJxtqMogzPioT1S44n+WuIdPEiqo=;
 b=cClSuTRC/QP65B0vt1XHZtVd0sKzq7OFLpu4BP5qw7MqLQZcCDSu6zvDPVSCqp/gNg
 WsIkbg9DkyseHMM0vwB0iwa4Q4nFgl36cZ68YtLQuOVoioKJYU+Xm1qwfsmCnV7ZD5dk
 8c94S+V+dDkftFjSpImomb2r4bqQooVcwKXotgdtsNGAydARQMr0ar2il/l+3EGDPQme
 ROMElXUiQB6truqnjdMviACseOlxVsWB/F5FcVPvu6JEDNQbIgfsQxbTOL/U3Ob0aFwU
 NAWuYUB4HJKB9+sizejdtKb6BoHzxUwhcr7X7DZEO8FyeiMbR32icmdLhIkfpbnSs/al
 kegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779451009; x=1780055809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BfxQWgFxKuSlI+XcJxtqMogzPioT1S44n+WuIdPEiqo=;
 b=Iynxg88Zt8wtgyEtm/zghg4y+1O0ps4psfi8TnNgQrmecANwKRvUS6Q2f8Edjuyp3v
 fm46Rx9xmZKiZW8JIUSHPPoPKZiKBAO46H2oGfcAl0uYeLvI2PJN6qYQhgycS0rDW7X8
 qFnKx08bab8duYMaH8Ha5tIVGx47UZqeW0SW+jszk0w9FAarP7F44usN93JdU1PdmDiU
 DNtowVXyFYNRemg1BXqXRYb4JtPY84wn5ZlqfTB5zew1M/usiwMHbkLII4lBkMezABSF
 NHc+eL3nI5UIrRolTgbVueN8D9eFNDfL4f5GFYJ2SGErZZSu38tqk32VUWYGOXY81jK0
 gxQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FG9IuntHLJWLi2iiRNenpqfywac5E7Kv+bD3LgiuFaHlhOfncTRlKvN4fqUJn1q0Q9YGKeITjh1c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxnXPG2qXmvoC6Z4Ruq+WY8EvS+EsVyTU43j3/KywGJzyL0v/j7
 uN8wGyZFrSgDomN35Kz3nl12V6laZiAlFNm/Q032lL+wNXQPqkeaoOe23fl8QUJ7iOFj4kil3WG
 oOuRYPs61xLiGiTqqROK1x+iZ0vrKdyJ8As/n70CRynd2gb4+1AmWHg7tniYXKF3tzWNNd03f4a
 oMlZRt+Nag0xiDRkT8NDi6itxfIXkcKXwOdimiyltvF1lXbg==
X-Gm-Gg: Acq92OEt1o8D6R7i+DC7Q6bRg9Y2KAEadQz7qdIqqp7BJMHhKnHAU4Pmg9o9IltFssQ
 iFIsL6HJztJHKaGAlQcIQWiwJ9pYILmOfgK3hVpHiCL7nwc0xbMORWHLFEnCowRQVSY+w52YtBh
 bMK1Q+/e8AVATmZA81LjuPR7Q7tzYHz3d/I5Zp8iu95Fuw/+ZbVqE8i8lenkAqn1m5tXNwZWL8J
 GofxA==
X-Received: by 2002:a17:903:2390:b0:2bc:b80f:6782 with SMTP id
 d9443c01a7336-2beb0356171mr37657665ad.11.1779451008489; 
 Fri, 22 May 2026 04:56:48 -0700 (PDT)
X-Received: by 2002:a17:903:2390:b0:2bc:b80f:6782 with SMTP id
 d9443c01a7336-2beb0356171mr37657235ad.11.1779451007888; Fri, 22 May 2026
 04:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-31-01faacfcdedd@oss.qualcomm.com>
 <pc4brjias4ixewzlsvnlhqhlz774z4p6aq7j4kldu5ze2e35sh@tsm2mtrkk3zi>
 <b5b3b1b8-ed48-429c-a87f-0278a6632313@oss.qualcomm.com>
 <tlt2ffn2xz3mpeoojcciieh35zc6pyowlkcjtxkkrnaj32enne@mbcrdrnkmaoz>
 <07ff4730-2efd-4e9d-b632-9fbb517179f9@oss.qualcomm.com>
 <vdjgzhx4xkvid2ukp7j3yir3n4tr423riyzvyzkrh2ssiub5at@pj6wfcy4jz5q>
 <4b18f14f-d485-4b9c-a75c-ead6f7c80f95@oss.qualcomm.com>
 <k6y3e4fqfwkevvvv3zmzmovsrz4i6qkxs3duhz7khsggxwwa77@uogtrpuaxhnc>
 <d4c5d26c-47f1-4e42-9852-d407982cb4f6@oss.qualcomm.com>
 <djigwx5k7j2rkaoq7g6paor6l6i25srvq7chjqqnjlbs3shcco@x5drauwxzngp>
 <6a5144f5-8734-40ae-b170-eae107089a3e@oss.qualcomm.com>
In-Reply-To: <6a5144f5-8734-40ae-b170-eae107089a3e@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 22 May 2026 14:56:36 +0300
X-Gm-Features: AVHnY4KoZE6VMWmY1smVEZ2rS8RaAHpQGDsUz06mMBB6vW75iFiz_e_W26YjgfM
Message-ID: <CAO9ioeWBvrsiiEDAUxCHQKU8CC6wnm_c0fyXeWhzrEGyvdbrSg@mail.gmail.com>
Subject: Re: [PATCH v3 31/38] drm/msm/dp: add HPD callback for dp MST
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: SAiyaYIyVyDEJv2KelzBHfiBmyclr_yg
X-Authority-Analysis: v=2.4 cv=Zekt8MVA c=1 sm=1 tr=0 ts=6a104481 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=t178-CUVSRCeDOQkBIQA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExOSBTYWx0ZWRfX/8whXxQ7t0gs
 pmZXOUVIjdXy7H9FFb6l8v+deWzYlS0QrG6wB9bxoorwAIOAwQYJ/n/TJsuSDxm0FBh0AQ1qrlX
 1XS7F8EYjxSj6aJ1fUrT90ljW7kn3CWk8FhmwRe+nD9YoAJZZPB7WFwe6TQEmQFo5u6EuuO+QdA
 aqDegXBH0nCIrNkgCzxohh+EpD7UHpwmFLRgE1Cn/IlU75XYa+nA/tP3q2anQUs9ED+c9rbY0q3
 6/VKHor/URbE3vP6yJpi5qfzDm9619y7fDJ2KkWfXIOzRYmBtitfcMexHHXA5GFB5yKOmKERmUI
 zsIK/q5aGqsqCPY+nslvdZcVszTOhEtRZrza+7XyIGXOAnSYsozKv8fTVqk0ORjKspvdIeXk12C
 61i8k9/Ag7FkJ3KqcY86U7ZYLvirli4TU0ZJSHuWUIBob5UXm1rtZ4S7iWZPdgxSp4m8VUagBxW
 T3S8mrK24fhos1sEuQQ==
X-Proofpoint-GUID: SAiyaYIyVyDEJv2KelzBHfiBmyclr_yg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220119
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

On Thu, 21 May 2026 at 15:29, Yongxing Mou
<yongxing.mou@oss.qualcomm.com> wrote:
>
>
>
> On 5/19/2026 12:36 AM, Dmitry Baryshkov wrote:
> > On Thu, May 14, 2026 at 03:12:17PM +0800, Yongxing Mou wrote:
> >>
> >>
> >> On 4/19/2026 8:29 AM, Dmitry Baryshkov wrote:
> >>> On Wed, Apr 15, 2026 at 06:32:29PM +0800, Yongxing Mou wrote:
> >>>>
> >>>>
> >>>> On 4/15/2026 2:43 AM, Dmitry Baryshkov wrote:
> >>>>> On Tue, Apr 14, 2026 at 05:51:51PM +0800, Yongxing Mou wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 3/25/2026 3:30 AM, Dmitry Baryshkov wrote:
> >>>>>>> On Tue, Mar 24, 2026 at 09:04:24PM +0800, Yongxing Mou wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 8/27/2025 2:40 AM, Dmitry Baryshkov wrote:
> >>>>>>>>> On Mon, Aug 25, 2025 at 10:16:17PM +0800, Yongxing Mou wrote:
> >>>>>>>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >>>>>>>>>>
> >>>>>>>>>> Add HPD callback for the MST module which shall be invoked fro=
m the
> >>>>>>>>>> dp_display's HPD handler to perform MST specific operations in=
 case
> >>>>>>>>>> of HPD. In MST case, route the HPD messages to MST module.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >>>>>>>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> >>>>>>>>>> ---
> >>>>>>>>>>       drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++++++---
> >>>>>>>>>>       drivers/gpu/drm/msm/dp/dp_mst_drm.c | 34 +++++++++++++++=
+++++++++++++++++++
> >>>>>>>>>>       drivers/gpu/drm/msm/dp/dp_mst_drm.h |  2 ++
> >>>>>>>>>>       3 files changed, 48 insertions(+), 3 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu=
/drm/msm/dp/dp_display.c
> >>>>>>>>>> index abcab3ed43b6da5ef898355cf9b7561cd9fe0404..59720e1ad4b119=
3e33a4fc6aad0c401eaf9cbec8 100644
> >>>>>>>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> >>>>>>>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> >>>>>>>>>> @@ -500,9 +500,16 @@ static int msm_dp_display_handle_irq_hpd(=
struct msm_dp_display_private *dp)
> >>>>>>>>>>       static int msm_dp_display_usbpd_attention_cb(struct devi=
ce *dev)
> >>>>>>>>>>       {
> >>>>>>>>>> -    int rc =3D 0;
> >>>>>>>>>> -    u32 sink_request;
> >>>>>>>>>>              struct msm_dp_display_private *dp =3D dev_get_dp_=
display_private(dev);
> >>>>>>>>>> +    struct msm_dp *msm_dp_display =3D &dp->msm_dp_display;
> >>>>>>>>>> +    u32 sink_request;
> >>>>>>>>>> +    int rc =3D 0;
> >>>>>>>>>> +
> >>>>>>>>>> +    if (msm_dp_display->mst_active) {
> >>>>>>>>>> +            if (msm_dp_aux_is_link_connected(dp->aux) !=3D IS=
R_DISCONNECTED)
> >>>>>>>>>> +                    msm_dp_mst_display_hpd_irq(&dp->msm_dp_di=
splay);
> >>>>>>>>>> +            return 0;
> >>>>>>>>>> +    }
> >>>>>>>>>>              /* check for any test request issued by sink */
> >>>>>>>>>>              rc =3D msm_dp_link_process_request(dp->link);
> >>>>>>>>>> @@ -1129,8 +1136,10 @@ static irqreturn_t msm_dp_display_irq_t=
hread(int irq, void *dev_id)
> >>>>>>>>>>              if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK)
> >>>>>>>>>>                      msm_dp_display_send_hpd_notification(dp, =
false);
> >>>>>>>>>> -    if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
> >>>>>>>>>> +    if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
> >>>>>>>>>>                      msm_dp_display_send_hpd_notification(dp, =
true);
> >>>>>>>>>> +            msm_dp_irq_hpd_handle(dp, 0);
> >>>>>>>>>
> >>>>>>>>> Why is it a part of this patch?? It has nothing to do with MST.
> >>>>>>>>>
> >>>>>>>> Emm ... maybe here we can directly call msm_dp_mst_display_hpd_i=
rq..
> >>>>>>>> I tried an alternative approach by calling the MST IRQ handler f=
rom
> >>>>>>>> msm_dp_bridge_hpd_notify(). I expected that when hpd_isr_status =
=3D=3D
> >>>>>>>> DP_DP_IRQ_HPD_INT_MASK, the hpd_link_status read in
> >>>>>>>> msm_dp_bridge_hpd_notify() would be ISR_IRQ_HPD_PULSE_COUNT. Tha=
t way, we
> >>>>>>>> could handle both SST and MST interrupt paths in msm_dp_irq_hpd_=
handle().
> >>>>>>>> However, hpd_link_status only reports ISR_CONNECTED. So I had to=
 move the
> >>>>>>>> MST IRQ handling into the IRQ thread. Do you have any suggestion=
s on this?
> >>>>>>>
> >>>>>>> When are the link status bits updated? Please remember, we need t=
o
> >>>>>>> support all three cases:
> >>>>>>>
> >>>>>>> - Native DP, native DP HPD pin handling
> >>>>>>> - Native DP, DP HPD pin not handled by the controller
> >>>>>>> - DP AltMode, DP HPD pin not used at all
> >>>>>>>
> >>>>>>> In the second and the third cases we will not be getting the IRQs=
.
> >>>>>>> Instead one of the next bridges (connector, EC, AltMode, etc.) wi=
ll send
> >>>>>>> the HPD event, which lands in the .hpd_notify() callback.
> >>>>>>>
> >>>>>> I added some logs and did some testing. I think
> >>>>>> msm_dp_aux_is_link_connected() only shows the current HPD state. S=
ince IRQ
> >>>>>> HPD Pulse Count is very short, by the time we read REG_DP_DP_HPD_I=
NT_STATUS
> >>>>>> in the IRQ flow, the HPD state machine has usually already finishe=
d pulse
> >>>>>> classification and returned to Connected.
> >>>>>
> >>>>> But the IRQ should be sticky and it should be readable from the sta=
tus
> >>>>> bits.
> >>>>>
> >>>> Yes... I=E2=80=99m not sure how this is handled on other platforms, =
but on LeMans
> >>>> can not get IRQ status from msm_dp_aux_is_link_connected().
> >>>
> >>> Can we clarify that somehow? Maybe with the hardware team if it is
> >>> uncear from the HPG?
> >>>
> >>>>> Note, in the USB-C AltMode case the HPD machine is not used at all.
> >>>>>
> >>>>>>
> >>>>>> Because of that, the condition hpd_link_status =3D=3D ISR_IRQ_HPD_=
PULSE_COUNT
> >>>>>> will usually not be hit.
> >>>>>>
> >>>>>> do you have any suggestion that in how to distinguish between an I=
RQ event
> >>>>>> and a plug event in .hpd_notify() better? We probably don=E2=80=99=
t want to
> >>>>>> introduce another state machine.
> >>>>>
> >>>>> Then, I assume, currently there is no way to actually distinguish t=
hose.
> >>>>> The easiest way to handle the replug would be to store the current
> >>>>> "connected" status and verify if we are receiving "connected" while
> >>>>> being connected or if it is a disconnected -> connected change.
> >>>>>
> >>>> Emm.. Currently, regardless of whether it is the native DP HPD (on L=
eMans)
> >>>> or DP over Type=E2=80=91C Alt Mode(test on Hamoa), a single plug eve=
nt always
> >>>> results in two or more identical .hpd_notify() callbacks.
> >>>
> >>> Could you please check, why? On Hamoa it might be because of the LTTP=
Rs.
> >>>
> >>>> In other words, after the transition from disconnected =E2=86=92 con=
nected is
> >>>> completed, there is still one more .hpd_notify() with connected =E2=
=86=92 connected.
> >>>> So it still can store "connected" to distinguish between an IRQ even=
t and a
> >>>> plug event from .hpd_notify()?
> >>>
> >>> I've sent a series, which explicitly tracks the IRQ events. Hope that
> >>> helps.
> >>>
> >> Very thanks for sending the HPD IRQ series
> >> https://patchwork.freedesktop.org/series/151522/. it very helpful for =
TYPE-C
> >> MST.
> >>
> >> I=E2=80=99ve been testing it locally based on HPD refator series, and =
TYPE-C basic
> >> plug case works on my side (although with some local modify, maybe now=
 it is
> >> workaround). At least the IRQ is being delivered correctly now and the
> >> simplest case works. It still need to do some additional testing.
> >>
> >> There is a small question:
> >> When do you plan to merge the HPD refactor series?
> >
> > Would you or your colleagues review it? Or at least T-B it?
> >
>   I=E2=80=99ve given the T-B. Could Konrad help review this series?

Konrad can do that. But why can't the display team review the series?
Or other patches being posted to the list from time to time?

--=20
With best wishes
Dmitry
