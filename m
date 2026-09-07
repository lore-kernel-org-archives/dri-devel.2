Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4953C79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BF6210EA54;
	Tue,  8 Sep 2026 07:08:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QfRxuRTP";
	dkim-atps=neutral
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA4CB10E046
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 18:13:27 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-90cc64570deso59220996d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788804806; x=1789409606; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qE1cFGUPU2WBN+CugW9PSSVbaWhX+WvGyXn9/fVdNR0=;
 b=QfRxuRTPtRMXDgNYJc9czfraV3wEC2j767aMKJ1HoVex4sgNsEtpVXLpKtqHx99u8H
 BEa3Dw418G8Sn0+kwKVfLmOjSYYIaJ4cL6XNfnuly/fQ4hLcl2EHCpXvC+EO9HXUlkoG
 CFpymeTH1DwePj/mEaFHgLqnS2hxALpupHIE3hBEuXk+VUDBNGC9byB8ahnB4cVymABM
 2AfUsTDZjnU+8BDStRvQ3iL21fOWRcQksk4IZsCbikjbu0AF9YAtC2TmBsFb5ceDiyUV
 pConGR9ZWt5UqXK9U/LwDr63b8G69Iy5GAv4UHVHWmvPyRsxaMyDbdomvJxdIY+amoVG
 eNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788804806; x=1789409606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qE1cFGUPU2WBN+CugW9PSSVbaWhX+WvGyXn9/fVdNR0=;
 b=aGtdIHdNspxPK29uKNmQJ849tL7v4zxqB45UGXDOlkBbN0O2bxQFGYFmpfmpTQrFHt
 2PL2sGuiqoXmNke2ulRWc221qUDJkA46qE2WkhOYB66j3PSnqusc7mO//SA8J3kgrThc
 +dxgzPVSki7fsRR+oJGbBb4qcob74lljPWK6jc3ne8yRYxXqht6UeVDexXcuaVT9JorR
 ENf5EE3wpZ2Q/r246BBKY7IEd+y13C+fPX44RN4zfgbIHi7omLZBGh7zyMz1G/hxeDFr
 uCrl8AlIeKm+B/4jx6JVJFMJw6rD8ApKO27hr20POjg5vgFB+2aqpJhSCx2cObiZOubO
 znlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx47yjF0E/S8pdLVizyouWhfHXiV5wUiawDuc6huHfr15owW8LOP0wtatuWitHeSLRAqZ+4ruLaOgY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lkyZotlNxDPrP6aaG9Pj95HpndWQ9Jhyk0p/f3xwm5Wi3EvTvd
 1ieR5NoGyW8CK5IJNtUknjDVleYjy2+2n6gqTrhK99lD1CZnAOYvNbNV
X-Gm-Gg: AYBFou0Pxmi5CiFrEijyZHLNyaXH/LnzXc0E3ua61g/EV888kpPCJr1JBro58iTLb0o
 OuisstFCaSRUmVYW/716S4IlD+pzputrUIZqfR6BPhq7VP2O3bm2GkmCnIhyw64Vk5I4s9PYQfA
 4WclMmBe5Sm1W4rTp3JR6T6WhhMHQEz3IJptSraC1HUDL6r6bkwj0Bz4mfL2KjlGGMbahnmkUH/
 8DKjb+kXb7Z+dMa4b7Mg017KrWX82aDpqBCrnSPs5dyGHAeupieAZi9Vy5mUMD9tkRYfJm5hScF
 e00nJBWGHunEJOfdAHDDXcUJmlqvuSS1LpoVglhbd2ISn1bcOauqt4fyIhdzh7Qb/RzFC+XFYNx
 C8kiWJzMmyk2HBgh8xKM4lYIGg24ArSpxQlkUp390mVmAtP1e5iIxX4PWmjev2RwJ30ptvJk0Mb
 xcVRcMX3UsalB33d5NYYxh66ZQuH8BQHW08YP7JH2qi0epXo2+kDfQxXpCeeXppXa9si+FNhkMa
 yKW0A==
X-Received: by 2002:a05:6214:acf:b0:910:3923:cc6b with SMTP id
 6a1803df08f44-9103923d142mr240278646d6.20.1788804806567; 
 Mon, 07 Sep 2026 11:13:26 -0700 (PDT)
Received: from localhost ([35.11.35.209]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-910406bbb79sm97374976d6.47.2026.09.07.11.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:13:26 -0700 (PDT)
From: BurningHoryd <sjunhyuk1@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Vinod Koul <vkoul@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: SM8250 USB-C DP alt mode: DP AUX times out in reversed (CC2)
 cable orientation
Date: Mon,  7 Sep 2026 14:13:25 -0400
Message-ID: <20260907181325.89746-1-sjunhyuk1@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e1971874-6e06-4ffb-8118-c4acc40144eb@linaro.org>
References: <20260906225206.2994952-1-sjunhyuk1@gmail.com>
 <f0fc4211-2040-4115-9847-6e5cc3fe8161@linaro.org>
 <20260907162643.36585-1-sjunhyuk1@gmail.com>
 <e1971874-6e06-4ffb-8118-c4acc40144eb@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:43 +0000
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

On 9/7/26 18:35, Neil Armstrong wrote:
> Yes if it's a discrete SBU mux, gpio-sbu-mux was designed for that, and
> keep the nb7vpq904m and just drop the SBU link to the redriver and replace
> it with a link to the SBU mux instead.

That fixed it. A gpio-sbu-mux node on TLMM 8 (select) / TLMM 9 (enable),
the connector's SBU graph endpoint moved from the nb7vpq904m to it, and
the nb7vpq904m's enable-gpios dropped (TLMM 9 is the mux enable, not the
redriver enable). nb7vpq904m stays as the SS retimer-switch.

Reversed orientation now brings DP up reliably - one normal plug and
three reversed re-plugs, all four train to 4 lanes and stay connected,
no more DPCD read timeout. Normal orientation is unchanged.

This board (Retroid Pocket 5) isn't upstream yet, so the fix lands
downstream for now, but thanks a lot for the quick pointer - "nb7vpq904m
alone doesn't switch SBU" was exactly the piece I was missing.

BurningHoryd
