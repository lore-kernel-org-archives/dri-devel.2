Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C43103A999
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F7910E68E;
	Wed, 25 Mar 2026 02:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jHDI8YyE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LP2bC/OP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A08A610E68E
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:30:51 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OMecnL2276760
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=YceOkHPGlNN2ifrpvIEOsk7E
 F4QKVtahHxaHBwe1Tuw=; b=jHDI8YyE/yEBlTuk0Q0epRqP5suGrTMUHkkzo9bX
 FMRUNCX4FxFfr4YwUkqTiq83opMcWzEYK1hIQ4ydRRQzAr2JJE9luIjRfGLkj8TW
 XTutQ4x93sLBr2lFTxKnkrVP5WApoHfLiiJ3v66z1jYc0iBRxqOGhqnVLJOjP2Id
 69buDgzxcKeQeVEqngr2obn+69TGNwQ+C/9+djGP/VwezcA43OahmzKzNBVlKKmM
 CmdulDZuPgk/b5kYnRW3ExNKejNCXT1tLUUZoJtzbR5lKj2rgERyIGxeUP5FVoHr
 PMNMpHUiediA9Sul4trNoPEIKeqqoykGqJSDuDP7xMd95g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d40ras25d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:30:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b05370ec01so379931245ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 19:30:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774405850; cv=none;
 d=google.com; s=arc-20240605;
 b=IA0dk7hhnMIaho3a6bSXnfnA7phMcRw1Gw2hEr6IG+PlNE6GjNnj00RKMgMlXNSLFh
 acc50F46uK56r21EXXiXrQx7Icb5V1RlTPWHZR/qndU7/TlD0feqqGblInG4D7+Q73d/
 /+U7+8PbzCsyqPNNBIUQev6nH3qu01AEH17M59WAiEOXxhxP702EnksV5ZTAtYRxlgwM
 +ABiJJuArpAGQ/tG6TsYZt7fT1zOToLLuy/tCegi1UJFULgl0/3KVZ1t2LhglauFyWHC
 svAccOL8zTKJJp3v3zIWJG+dalI468A83Wg/KtGa6pzlGJ5wqFLd+HqwUL/a4FSbzX03
 GIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YceOkHPGlNN2ifrpvIEOsk7EF4QKVtahHxaHBwe1Tuw=;
 fh=cnKfEgVbsKQNA1lLcexw5BkCpD1YZ6agxGRPlOAMeLo=;
 b=Nel/+weko1a1TXGt2X/HKu1fmPdama0emcqqqBYX5UVnt1CYJ0cH2GxMbUgwlAd5VB
 5k3BZtynJ2Ntd4v9qt9pMFkJVhio2uA8DwcuWtjQqypfule6KWt0PNHzzw4cQGkWTL3e
 xbDJPhD4Oz2RUqQVhWez05DLrPCIjP6zGRAFmnm36FFzQKBtN6bQ9XxKIvcLfRj7Dd44
 qLBVFtffkfgL9D/Ii6vmksbKlzTNKoJUV+V36K3KLUnkUPJhyPnEQXMtHaFh/ESoptsC
 7TEKPS9xWLvuiJpZW3ZyaY0Cq8x8UKoGV0i47D1283+dud4oNRhgR+3sNtrmbU5+Kesi
 jIQA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774405850; x=1775010650;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YceOkHPGlNN2ifrpvIEOsk7EF4QKVtahHxaHBwe1Tuw=;
 b=LP2bC/OPWX75jpK5zlmc5O26bJIsYH+rknP+2wRXjJn7XjHvdr4H2z5PBeGkBWVzmK
 rc7UdpIUXd11DlMGjaorBU7oO4Yt5B67K9cq9PmXVNxHkuH2tkSe1p8iQ6i3h6FEAadN
 xeULxkuUmcX48xUH+6EaHrbHW2qHQyJ9xZXngdIqRi/ATmfkIQCuDaCbKb1VECxCyO3U
 N0nMJqRJFsH+63Q1m3FwwePBUaRJLnQ5FoknkrdX7GhQwH6AcDfKy4HCRK3z6Pbbd5UO
 jS+YpMSvHmRxoRNt7YEll/OZLomZ0SEQ3Rx9NlzehrvkmMrSSMCpITUcfWNsEIqJbjKv
 woig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774405850; x=1775010650;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YceOkHPGlNN2ifrpvIEOsk7EF4QKVtahHxaHBwe1Tuw=;
 b=Md7h5kMc5CP8a8zYehSRgbhUnxiUDzaj+5tHbUmfyn1kiqIHF2AXlNGfThXAwKyESx
 Gw3D/rmUhMxTSljnlJcknGj3MRDb2bnsRkUHaWw9dt0hmAe0nSQcALPTQj88WQaoG/5N
 0PkXxZZE3qNanx4JUQW+yvv8wjZgsnOpCMpCGLA3RjoLrrmh1berMscz4SGjh7QmW6/K
 tDpevWF2+8YRyxVUnHMZFuqorGWoXk7koQcs3MNIqJU426n6SqBwg/TszcQWpQwHsP3j
 CQjemESIey7F2ekPECxJnIdpNatVCjnnXo8zqUcwEewHLIsSy1/M/stu8LeGdXGLl/n/
 tVUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXClb8O+QSAaiPP0PxFjR3Hm2yLqjybJWLCt7GXJ5XZGFOiKWQaMwqZpxGujqP62ruEBgtihYTJezA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxv3ylz5OVqMX2beGhNywEhqWWcpjRiJXgHf6eBPXvB45IpTh6f
 DCfidIGgwdn8C6fam+jn6iTDL9P1nJ3bsAQ1pUDmHWXOOVwOgKNomB+0mURyX8x5Mgr9gK/ie79
 nblHbYMzbOUNQL2YZG7q4aCGV+b29S5abgxZjN9fs2vTcNMMVEekUpoJOGOhhlUkxqcET7bcVSz
 5VIZyK311TzwIihtlkHu3FhujKvNv/CwDeK/dR74WkCWnA7g==
X-Gm-Gg: ATEYQzx6fVkxeDAyUhUNiHA4y/08OZMmJmwm+afPGFx8bzN8BXCynBVBdpwZLB9xwxj
 UPx57qAfO4Pp4P4RxKQu6y7IfeGfq9uu4hj7KoNJA/bvdJIQFi+s1QulzYvHUkTPY1BELyuTq9T
 ge6GUhXJ4sotSx+QkjsCgsM9dD7rnZEzsjn9V2kOpqLkMmBEIdEFRmeS3Rd1vVroDkheXrQjqhX
 X1OSZI=
X-Received: by 2002:a17:903:182:b0:2b0:54dc:63e with SMTP id
 d9443c01a7336-2b0b0ad238emr19820835ad.33.1774405849524; 
 Tue, 24 Mar 2026 19:30:49 -0700 (PDT)
X-Received: by 2002:a17:903:182:b0:2b0:54dc:63e with SMTP id
 d9443c01a7336-2b0b0ad238emr19820325ad.33.1774405848540; Tue, 24 Mar 2026
 19:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260319160110.109610-1-tzimmermann@suse.de>
 <20260319160110.109610-5-tzimmermann@suse.de>
 <i6glsf2tfikmcfen2xkvxnqp7kddfgyctbbi57pca23nx5mefb@2qvwne42uf5r>
 <4073c852-dc6e-45e7-a758-d43934bd3afc@suse.de>
In-Reply-To: <4073c852-dc6e-45e7-a758-d43934bd3afc@suse.de>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 04:30:37 +0200
X-Gm-Features: AaiRm53uig_gSb1v85wJ9cFHgcQwV6SLgxkqMQlFP4YfvqcgFeBDqymkbqHwMO8
Message-ID: <CAO9ioeWXn-nDsMesemv97NmkZM=KcLyN8PC6uz5a-+eeJjrtJA@mail.gmail.com>
Subject: Re: [PATCH v3 04/16] drm/hx8357d: Use regular atomic helpers; drop
 simple-display helpers
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: david@lechnology.com, javierm@redhat.com, lanzano.alex@gmail.com,
 kamlesh.gurudasani@gmail.com, architanant5@gmail.com, wens@kernel.org,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, simona@ffwll.ch,
 airlied@gmail.com, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=Jvr8bc4C c=1 sm=1 tr=0 ts=69c348da cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=WZHNqt2aAAAA:8 a=syA2NUEBELLVZjl2tskA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=PrHl9onO2p7xFKlKy1af:22
X-Proofpoint-ORIG-GUID: BUxqbWb0aVx2vhHh6kdQr5TLolD9D-8Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNyBTYWx0ZWRfX8nK2TwOnQZ6x
 2X+ojTFpQPNgC48N78tPbJBtczAC3ZTlDLNO4qlfDz9SPBhRXHeiufZgjP15iRpYwQUYGGxzXtt
 pYGiQAUUnd7R74kcjOxm+kJSmjgbZqEptitbTCgh6VqriZsva1J/uijgNkOoNucaOyzUnLlJn9P
 nZFuXQG2F3Jwb0hgMd3p+0i0veFSbmuMeD8XeGpxMhwD9rp2o/Myc6zZdvHfZq8brB30RQMp/Ho
 zp3TXn7nT88an8gRUlCBSSt7ZYN4erCTcsvkWJmESMXfEjiEbzPDFR9vGqzQDxQ3sdghkpM59Ns
 d6DXX9Py0GHjEtFvOo9bXRdRvXYGi7/acCsa+av1Drmf8oTiOJE2CRAZsxPb+1hX5qMSsiiCH8g
 g4fQzIDtbK0c6zzIfi3vWGF09Z/xOwpnpOyQvfsMKs0BsTWxpYqE1JX1p3wcEF6wu3Xq1M2yaSs
 u548CN+hzkpv4S0Srhw==
X-Proofpoint-GUID: BUxqbWb0aVx2vhHh6kdQr5TLolD9D-8Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250017
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

On Mon, 23 Mar 2026 at 09:50, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 23.03.26 um 04:57 schrieb Dmitry Baryshkov:
> > On Thu, Mar 19, 2026 at 04:59:40PM +0100, Thomas Zimmermann wrote:
> >> Replace simple-display helpers with regular atomic helpers. Store the
> >> pipeline elements in struct hx8357d_device and initialize them as part
> >> of probing the device. Use mipi-dbi's existing helpers and initializer
> >> macros where possible.
> >>
> >> Effectively open-codes the modesetting code in the initializer helpers
> >> of mipi-dbi and simple-display. Hx8357d requires a custom helper for
> >> CRTC enablement, and non-freeing cleanup of the pipeline.
> >>
> >> v2:
> >> - fix connector initialization
> >>
> >> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> Acked-by: David Lechner <david@lechnology.com>
> >> ---
> >>   drivers/gpu/drm/tiny/hx8357d.c | 135 +++++++++++++++++++++++++++++----
> >>   1 file changed, 122 insertions(+), 13 deletions(-)
> >>
> >> @@ -183,8 +215,35 @@ static void yx240qv29_enable(struct drm_simple_display_pipe *pipe,
> >>      drm_dev_exit(idx);
> >>   }
> >>
> >> -static const struct drm_simple_display_pipe_funcs hx8357d_pipe_funcs = {
> >> -    DRM_MIPI_DBI_SIMPLE_DISPLAY_PIPE_FUNCS(yx240qv29_enable),
> >> +static const struct drm_crtc_helper_funcs hx8357d_crtc_helper_funcs = {
> >> +    DRM_MIPI_DBI_CRTC_HELPER_FUNCS,
> >> +    .atomic_enable = hx8357d_crtc_helper_atomic_enable,
> >> +};
> >> +
> >> +static const struct drm_crtc_funcs hx8357d_crtc_funcs = {
> >> +    DRM_MIPI_DBI_CRTC_FUNCS,
> >> +    .destroy = drm_crtc_cleanup,
> > Nit: would it make sense to use drmm_FOO_init for all allocated
> > objects? I think we have all corresponding functions except for
> > drmm_universal_planes_init()
>
> I know that some prefer that style. But for these simple drivers with a
> fixed pipeline, it seems like a waste of resources to me.

Ack, thanks!

-- 
With best wishes
Dmitry
