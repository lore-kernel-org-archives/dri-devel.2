Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDB9606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=ANZHlEDh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C47C10E1D6;
	Thu, 29 Oct 2026 21:20:46 +0000 (UTC)
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECFCB10E1B5
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1793308832; x=1793568032;
 bh=ZSMB2np0saGPi9BQgWmba3/r+83zAZaobmii7tWhboM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ANZHlEDhdkMwH2ixaHgZGtlq/x5AbOL4mGea7AIzCPbMrNvW08KCNe4rIAZE6OlMQ
 U4rPWQzprfVZCA8qpAUYsBiWZItJYCl5cVKagML5hFKgQXykd7FdJjyj/n1kPwZhDW
 BTnqADitePGJrx3QFgzjAOvIxD07REtfH7gcFUk9T4VsroObMP6HhLQ+oI60RfhVEi
 JTvR07OTaM+135K1q1m7V5J5MAExRp9/0xa9ZPSrUtRuHXRGRHTX1GphFZjBTwPvhO
 HcNvr4W7DdF5zNeLs1Hu1B4ZtLhS8oj2+fTBBSymiAQvwQLyv3vn2W2Nt+Ao8w54VF
 ubrgPmoZzitVw==
Date: Thu, 29 Oct 2026 21:20:27 +0000
To: Rob Clark <robin.clark@oss.qualcomm.com>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/16] drm/msm/a8xx: devcoredump state capture support
Message-ID: <72mcRc_XaEFYOXsQm5r3_QWSIcGfu2OOwWlCRp086BzS5v9e19_2L3wttKhZOHho-XlIv1lZODbEYPFwnSVWDEQXgilHOfqgP5U0t2xsNcA=@pm.me>
In-Reply-To: <20261029201730.151754-13-robin.clark@oss.qualcomm.com>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
 <20261029201730.151754-13-robin.clark@oss.qualcomm.com>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: f4967a0771fa19f5e415ddc6b26b2f632f0fe9b8
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Thursday, October 29th, 2026 at 4:20 PM, Rob Clark <robin.clark@oss.qual=
comm.com> wrote:

> +static struct adreno_snapshot_sect
> +__snapshot_sect_init(struct adreno_gpu_state *state, uint16_t id, size_t=
 extra_sz,
> +=09=09     void *sect_hdr, size_t sect_hdr_sz, const char *func, int lin=
e)
> +{
> +=09/* A few section types have no section header: */
> +=09switch (id) {
> +=09case ADRENO_SNAPSHOT_SECTION_REGS_V2:
> +=09=09sect_hdr_sz =3D 0;
> +=09default:
> +=09=09break;
> +=09}

Heads up that I'm seeing this warning when building with clang:

In file included from ../drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c:9:
../drivers/gpu/drm/msm/adreno/adreno_snapshot.h:398:2: warning: unannotated=
 fall-through between switch labels [-Wimplicit-fallthrough]
  398 |         default:
      |         ^
../drivers/gpu/drm/msm/adreno/adreno_snapshot.h:398:2: note: insert 'break;=
' to avoid fall-through
  398 |         default:
      |         ^
      |         break;

Thanks,
Alex
