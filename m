Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC8B606A331
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Om8C4zxm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ia/EMkxU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9382811214F;
	Thu, 19 Nov 2026 08:25:59 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75DC1112144
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:27 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6vRQ2053085
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oEE/mqi6JoKDrenw6SXjNhEhAciqo4FTpGNcngltvto=; b=Om8C4zxm4DUUiKh6
 l9XE9R71z/YM58bUd3iSfN/Yd97bBeT6T7F/sqedWJP7xY+XX9TsiQA8vp27Z73G
 18/LDP7efi7tkIujuKG1LdTzlVKrT5bSookVsex29cc0cSZHRwjIgUhJePEI3rWD
 wy1AJYu+tb2RwsPLGKj4yGSxJa0bCtvlr2EAPcEQ0X4mVzwLuL5uBF3gAYATrlf5
 o7w6DkaVQkNA9Wz6ZXz2t1l7p1bnJGNkapAE/dH33DMqmkzVkHIhJuL2LdUIAFr5
 pg36xPYHxvqy9QvXRb+HVTv8qJz+UtJrb84HVwgxxN5qoLIIB6laM25P31GoReVz
 iHWAsQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g3bbgjq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f2c0e6653so343959485a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076726; x=1795681526;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oEE/mqi6JoKDrenw6SXjNhEhAciqo4FTpGNcngltvto=;
 b=ia/EMkxUQ0iAmU2A7ZalX1MOv073GVWh8VAEKCRRx5bn9MGr3TZWedSJVdqhQ/PawJ
 vmP1BeASOe0rvqmjGY+pPpeMZvNM6Ylr8609NOxLd2uaXbiykOmESqklCrQ/dBzbznQ5
 3St7cgTYv6kfjzPJj5xHI4edy+NV8+4npWWbugm0Y0gHhSbWjJQZx0ZfBze3h3nLaznV
 Bw+Da018CDZebiZrekUmH3WejsiZqrxBSbHZfkGKjfN/t2E85E8asu86UWMNb4+PQyLM
 ISbNODvgebD9DO01yWlOyrU8U7Qd0TFxqSwJAg33fssvG/fSsqajxnjvcW0GRqZMT0O/
 nAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076726; x=1795681526;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oEE/mqi6JoKDrenw6SXjNhEhAciqo4FTpGNcngltvto=;
 b=zba+z9ps3bsI4tG1AuQCoc3lej6V2syeEWddC6eHvBbvzGU+vNGM8F0ZG+S1RzMOS3
 l3Fvi9ea5Nuglmvzofmx6nmFUQ64uHvohCcZ0mg+wjMIge2HnwMoj2BYzqVn7qF7zoi3
 G0UKpCQDjGHHkONgCOL8Tk7t+8FIEw/8qm9QT4iJyEPgt3bTPuVZRkEQ4OYFECuBgL0G
 +5eXTWhxdw2iHhMD/LB3oS6CrCMLE7I86Pczq81KfyLlhXpeODau4EEqpJmld+hHbMld
 VFvjZZopgVL9a/El1S3JjqdZVx1AE9GkUzotkfJTfO/fXN4mcas3xnaA/CnQsyWicgRr
 aBVw==
X-Forwarded-Encrypted: i=1;
 AL+hErHTDc9uc1n0a8b/Z2JLnoih3kIqMYdG+BKzuG5lBFmp+D8FjWIPRMEEV2kB391QkjGMInMU+6yy/oA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8xILV5LlsGgnJLxN804NnZ1pwzyadwTnc4DfsnStjW9FL5Tjv8
 PfxXk2jk5Uno/Ro0fWIODYEf6Fj9T0IfFFppyghRSvrL9eROtjAiTVFIInUCp7gWtmcHaUuZa25
 huhdZ3LJl32YcTKGmVuNum4jqUDrcSvgjt0snh/Au2f3WxusD7p51WrIl9GP4Jtmj07B9zgI=
X-Gm-Gg: AYBFou32o3j8gK6h3IU9W4zSevvIQSr/U0Avd9GRM4A9L1+tAwYV8hqwcyX42qSDtk6
 mnlGQDgu4fFYNXnRCJ5XHYgIxs9VfkSx0jNdq6VRN14FJyryS5PWSy0idArrawYw0Icy1p0s4Ha
 1EUz2xr6q0hhDeqRtZ/OIGUd0RXJfWE0x7VzyofqygBpyzRumjLQTMUbxI7qv9FXn0TldcKIR6F
 52iw+uNVgGXVloKutTbATW8bnu5Vbd2Hh14PgdyOsJuwS0WqQzYsG4aWb21bkUUT/lus9Epos7s
 qzvWfVm9yWtR+4qfkqmDVOYbORMK2YK9mixND1H/yt7NK8gwE5cG+/cdOucVhj2nEqzCyP+nMZ8
 DGXyTFBsXRbZ72jmTb95KnEz3Dw0ay3JXNdgNwAE4KZO1+nsZKFpgVNI4rKqsdojD0BUwzc3Wtr
 y3wjGyabS5lkmUe2ZMgMa1er/zBZZZk7vhxTBXKUjQLwKEQ9RgwQrKhAQ47atHtA==
X-Received: by 2002:a05:620a:270d:b0:93f:5f83:2ca3 with SMTP id
 af79cd13be357-949997abec2mr858254185a.54.1795076725705; 
 Thu, 19 Nov 2026 00:25:25 -0800 (PST)
X-Received: by 2002:a05:620a:270d:b0:93f:5f83:2ca3 with SMTP id
 af79cd13be357-949997abec2mr858253085a.54.1795076725213; 
 Thu, 19 Nov 2026 00:25:25 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1aa75f046sm1234070e87.28.2026.11.19.00.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:25:23 -0800 (PST)
Date: Thu, 19 Nov 2026 10:25:22 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org,
 media-ci@linuxtv.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/msm: don't tear down shared VM mappings on
 handle close
Message-ID: <pk5k4tcrn6p2lrghqh2j3uprwaxuy3ugaewuupqg4ecky5xvse@3bwy5d5rozvb>
References: <20260822-msm-fix-export-v1-0-917b3cbedd43@oss.qualcomm.com>
 <20260822-msm-fix-export-v1-2-917b3cbedd43@oss.qualcomm.com>
 <20260822090757.624751F000E9@smtp.kernel.org>
 <CACSVV018ggaw_V+7GxGY9ZQrfg8UEfhHfHWiS9NoVe6LJkw2Eg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV018ggaw_V+7GxGY9ZQrfg8UEfhHfHWiS9NoVe6LJkw2Eg@mail.gmail.com>
X-Proofpoint-ORIG-GUID: n8_OY0Eih4tl3Y11RAdNS8bJYqNeNcvW
X-Proofpoint-GUID: n8_OY0Eih4tl3Y11RAdNS8bJYqNeNcvW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX/wYgD32/2iUF
 k0NwcD8qdwOQMcx+qwAYUQBJBHUz2uxqs5WjSwkCYAE1C35xBkGwIsGFp2bSBC0Ewbf8ILbAYK7
 nefXKJ35KuW8D5cE12KvDEolJnXLvSw=
X-Authority-Analysis: v=2.4 cv=dZQVTnXe c=1 sm=1 tr=0 ts=6afeb276 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=1fJnDc9Itneyp4R58M0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfXzLzUcl9n3Nhy
 roEycb/PUifOyjw10xYEZeXvEVsOAU9Aqxqs+sgvEBH+NrW1/n8vbUuoVULLEXYbDQTR/q800Sw
 8aPAYhjvlXbGXZUee+PG+Dr1f1zGEB4XfAxdigw7CldPGWZ87bJ71Y57XMRMh6x/YUhEwtF+1x/
 ATGm1j866t07jJZAfi8EuiXBTG5EyhGSC5lxlQGqAVShJ31bq3S6BRCiqQvT0ABeUtM8pnBateK
 C29pluCn/t3unrlikAu8WnUVa3tVQnxEs09Favf5qIWFBtrHZque1KNNw4OE3ECbs0hz3qr1MUG
 WTkwU4VYa+gAz1ULnbtv3hCfNhXYEa2tjudiilIY/zXaHyOtpXJn1T/wAP2mCH+7TcWlAUEWkf+
 vDWzq+TZ1MR4/VuPIquS1CqHkR2T80/KyXK+jWPWd3xxje4ocPRVUHs2TULsz6hQzO7d+1i0dxU
 EYvwH89kdWO4US1v4qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 05, 2026 at 08:00:07AM -0700, Rob Clark wrote:
> On Sat, Aug 22, 2026 at 2:08 AM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> >
> > Pre-existing issues:
> > - [High] Sleeping in atomic context
> > - [High] Deferred teardown TOCTOU race via flink name re-opening causing IOVA Use-After-Free
> > --
> >
> >
> > drivers/gpu/drm/msm/msm_gem.c:put_iova_spaces_locked() {
> >     ...
> >     drm_gpuvm_bo_for_each_va_safe (vma, vmatmp, vm_bo) {
> >         msm_gem_vma_unmap(vma, reason);
> >         if (close)
> >             msm_gem_vma_close(vma);
> >     }
> > }
> >
> > Will this destroy Thread B's mapping while its job is running, freeing the
> > IOVA for immediate reuse?
> >
> > [Severity: High]
> > This isn't a bug introduced by this patch, but does adding these blocking
> > calls cause a scheduling while atomic panic when tearing down a writeback
> > connector?
> >
> > The drm core function drm_writeback_connector_cleanup() holds a spinlock with
> > IRQs disabled when tearing down pending jobs:
> >
> > drivers/gpu/drm/drm_writeback.c:drm_writeback_connector_cleanup() {
> >     spin_lock_irqsave(&wb_connector->job_lock, flags);
> >     list_for_each_entry_safe(pos, n, &wb_connector->job_queue, list_entry) {
> >         list_del(&pos->list_entry);
> >         drm_writeback_cleanup_job(pos);
> >     }
> > }
> 
> Hmm, someone should look at this.. maybe we could move to an on-stack
> list under a lock, and then do cleanup outside of the lock?

FWIW, the fix is implemented at [1]. Would it be reasonable to pick it
together with this series?

[1] https://patch.msgid.link/20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com


-- 
With best wishes
Dmitry
