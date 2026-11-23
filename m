Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27724606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vMxQ7Q1V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D78410F32F;
	Tue, 24 Nov 2026 08:43:33 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F3210EFE5
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:25:59 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-8a070755c8cso1626937b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795451159; x=1796055959; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UKsPhBFXVevVRUvcrB6+ZjmJljc8N9iawL0bPcXvtQY=;
 b=vMxQ7Q1VZFpWLGj1Gonk0aYLsjqe41S8Rp7EqaW6k8xtJiObtKwvctUbTBAiwb6ybD
 9F3l6MF8/IgzNqoTU6xG+Jt0JgVqD3BsvaBK4qPiNZNn61Kkr/MeRNh5rOO4XFc+6DyK
 CmYuk/T1RUO0ppBjGA59vti1VlsR2bYoN4WQvLydClZsV9mJC4Tlen5Y+p37DtP2aPCy
 NMMY0DXsssFwDp9JPNqNYMl0jR+lNaeuWhM06WAikS0SzfZ/fwbwHfDD6V14LJ+v3NMD
 NqyVIVTnZl9GHwsSh7HjjAQdqxGwxthHHXm9KHSoUJKRVKsEfzXvFgyQcEoePRk/Byfx
 e/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795451159; x=1796055959;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UKsPhBFXVevVRUvcrB6+ZjmJljc8N9iawL0bPcXvtQY=;
 b=dFld+7bOFSumVwR3t+wMZXwA2I5uDFlfDoxBBcGwwyELWPJrus6aSOsZsouYXmwtxq
 TIbAd1iKalkN7xvkPHe9FzTjFS2YRwOXUKy8cOcu+fnHsZ9t/C7CxB5HfxUAWOc1zsd+
 3SwKRhOo9zy7fj726PqWiXCj3YymG4t+9uY2Lf38GNG7wgcgvzwzP9V9frSvO3w4t9av
 RYcX+1STV870WXrW5TrYl8qvrv0UeszCHyzYCQpt1TU/AnFcGsfbq3oz95KSYM4dVi8F
 QM/rkl1po7x18kMo6hiK5lvg9oKC7Jpy3b8LmA0flzFtURCzRvDGZs0EoyRy4kZkdvr9
 BUCQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH1CIfi86bP+p49DutKDjbnme3LnkaFLG7EW5K8/Hbkt0c2mL70UqoCHLRA86A9qA/VzhQcrtSSQ4U=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8HwTFlLODyIWtLYyKv6yZCrQsaItEaW3VRCg3/jU5vhHs4wa5s
 jlz2EVnZad/Siq2M900DK41eUk2VNqO7SgJjS+vDbx4a9qMHlwIcZtY=
X-Gm-Gg: AZFdTZdrXf07EnDD/vDewxuWDmQcuSVPke8QFyPQvZIGSfj51RH2Aw+LkcX1qNh84h3
 OIk7CFlUuzPlubryxFniFvl4bhjHQieYLDICR4ImdmHA7brywLUgQeYFbov2rnfthmrNZOQrwLi
 bTx4E/2/26wlmpHc6wwsuaen+kc46QdKKkNveFvicdfD1Fznx+rnLIECQ65tIMCotJwygovWgjQ
 2dEGJeXino0kgifKyabS6AwV0HTqo6GQ4SGJaUlMsDA5A9O+w9jOK3zYd36ce8YN1RMdnobvnOU
 2ZSLql0RVP0KE8ziPvDlc1U3+Xav4mZkUHJ1y4mQ6FU+iLl+q8VhQYOTUf1Egel7uk4+TZXpiRm
 jOxrTQyHFrcYDFAZFyLrxuDFN44+urSLkx6rRpU0mYaJaTXNh/jaxRrtR2HDxZ/ly9PNIu36nVa
 GIDCK0jOb/Y14vdEb1RaVTSp5xW0AxCdGs7RV6x2c3cJpMtY3GvnAA9PWkQ3czNxdjOmKcj1jos
 5YXEAoz47oRtGlbT0yhs4aklNLi9PMaScMiMJS08LsBDA8iIRZCPhmorQXdb3KjLl4U/MFfqVTY
 6OzfQpbrGmmBe89bLhMJpD4IJW3jgutjJdJIb2pbtTNjyeYpZMfxQA+EPaCLsCY=
X-Received: by 2002:a05:6a00:94c8:b0:89f:129a:9590 with SMTP id
 d2e1a72fcca58-8c87d01fbc2mr10377955b3a.48.1795451159489; 
 Mon, 23 Nov 2026 08:25:59 -0800 (PST)
Received: from [10.1.1.198] ([71.212.222.246])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872e4af1fsm5904879b3a.28.2026.11.23.08.25.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 08:25:58 -0800 (PST)
Message-ID: <6052053c-5e1c-46e4-98e3-e6e7608683c1@gmail.com>
Date: Mon, 23 Nov 2026 08:25:57 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dp: skip the link teardown after a failed enable
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 robin.clark@oss.qualcomm.com, Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
References: <20261104072048.3486286-1-burke.cates@gmail.com>
 <0212b0be-857c-475c-98a3-165df9de34c7@leemhuis.info>
Content-Language: en-US
From: Burke Cates <burke.cates@gmail.com>
In-Reply-To: <0212b0be-857c-475c-98a3-165df9de34c7@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:39:44 +0000
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
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/11/2026 03:00, Thorsten Leemhuis wrote:
> Was this regression ever resolved through the proposed or another
> patch[1]? Looks like it feel through the cracks, but it's easy to miss
> something from the outside.

No, it is still open, and there has been no reply from the
maintainers. 1bda647ce61b was not reverted, and nothing in
drivers/gpu/drm/msm/dp has changed this path in v7.4-rc4 or
next-20261120: msm_dp_display_unprepare() still calls
msm_dp_ctrl_off_link() after a failed enable. The patch applies
unchanged to both.

Two other postings touch the same function, but as far as I can tell
neither covers this path:

- Gianfranco Mariotti's 7/7 has a Fixes: tag for 1bda647ce61b. It
  gates the dongle power-down and PHY re-init on dp->plugged for a
  cable unplug; the off_link() call stays unconditional.
  https://lore.kernel.org/all/20261121214105.32596-8-gianfranco.mariotti94@gmail.com/
- MST v9 08/29 replaces power_on with active_stream_mask. After a
  failed enable no stream bit is set, so unprepare() still runs
  off_link(). My patch would need rework on top of it.
  https://lore.kernel.org/all/20261119-msm-dp-mst-v9-8-ca61be4edfc3@oss.qualcomm.com/

Xilin Wu's broader rework (hdr10 v2 09/20) has no newer revision.

I'm happy to send a v2 or test a different approach on the A16.

An AI coding assistant helped check the trees and draft this reply.

Thanks,
Burke
