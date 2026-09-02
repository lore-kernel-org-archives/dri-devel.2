Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E857C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8DF10F0E5;
	Wed,  2 Sep 2026 10:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D384HAa/";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF19110F0E5
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 10:02:13 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4957799b92fso406735e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788343331; x=1788948131; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dFXB7NNkv6fd9dgrONxWMWNxCL/FcNjOb3t58PmeVFQ=;
 b=D384HAa/UT5AicGGqiu3VW9387E8OKutB7fobRjYOwxvRQjufhZWvMK3pycrkRWTTI
 iqyIgmyobGpPFLPm+FASxzTVeVTdkrwerYuP6NA/jYY0qlnwEpoDhfdvcmYQsLrunsAw
 dk36YZq6C41zUxLTWoR2MVXhPXbAMVKpT9nCRsgrkavpYX7r8JTpmlAxJyN+VMI24+en
 RP25+gnEiiQn1plFfHqTXy0VAnQmWDLcXsRpyhI/ShbffR9PNFRJXAdf0Je+cLqA4B+N
 YSu+tZQKVHbWqeycPzH6u/xwqmy4P7LYUzc8kXNpWuAqIpMe/iBL+D/IWkYYpctit7L4
 kTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788343331; x=1788948131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dFXB7NNkv6fd9dgrONxWMWNxCL/FcNjOb3t58PmeVFQ=;
 b=mAakcpUdcvqLuabBAzO3q36AEbBSPaISop05+UyU7eNL+eb3G3N8VaJ/BCfn3xssye
 QGbi+c3hk1hN52icccqD2QWucVvBj2Kk+xGKolj0zBtINVRWH9MASINpDQE9vFlxyCme
 GpzhsUggIUMIE82ookxflMQjJD/TozkyOf8bDiZ91oNIfGm5ykpzyAbMAI+pOOzTB+zS
 A0kkc+QHxgD44eJEirbYHN/fUwdvMteV5i5MV1TSwv0fT6tXB9uWHPcm5ATNK7OKJ7F1
 k5QaNSnFVewNeuCXuo26lJtSTA7SkIByo1mn0FrkfkTtfuBzEmpJZ1eeHMAM7TPpp+fq
 J8Xg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/sfjrjLQwxECECsIF44aQykiKJsUp/BQZBnEuRibaOsm4JNQmccXXBA+0Bo7gFJmnd4hGV2uPTuM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l6cbxn53UGJ6/EVkwon2qEvBKQz+gWCVbjZIQjL2H3yTMzLXzt
 MCsa8bHq5s5GzIF5fmb6MTH/AH2jckjrUULSav5UJedrz5hfLluJxY0Z
X-Gm-Gg: AR+sD13UKKVH9GzRgggbnEt81u9qeP24zvQ/RthtiC0icjIr69HbWd0YJ3kLm1+SW0G
 9kT1mIuIbA/sM7kRMQlOuM3XXdvCMyykBDdD769/zUG9DXhCMHP9SjYfck8r7mrBUdDZf6OdiAP
 gJjf8D/6DXEopJeUYaO5QVb2Y88qNHosTX/E+pCfcPou7r8RAOKCt/7Em35cbjyLgNBtgatSjke
 RmxwVqNBWzr8tDM+qN6UdIyh1doZJgeC3qew8QxkFOaIZ+Xw/S+R7ZkX4/jFKuzTCCEYf6wXGkD
 eGjN5jb8i0TXC3Vqv8p+x78T6iELURg8cubklUPWwPq3NwKu5SI859yJ5ygD9inWvT6fTkmCyW1
 7NoaH0mVA86AerxDjMXFbrTzm5YbGYf+6+afIYLx9pK+WJadi8c6Ex5sauEPUbRGtYKeQFSfuUq
 arqoLKW4Znxxhl2NQzlaKamHW8LGlRRuui1tYODgLSQXX3ASzTk5Cp5jXrqO/4NVY8q3W9Yhh+2
 GjRkSi7T489u2UcPidxD+LbF2E8vzVTk/YMa2TAlv336EQdds3hW7jN8PVpXtyH6lYMZQ==
X-Received: by 2002:a05:600c:5487:b0:49c:ca33:9553 with SMTP id
 5b1f17b1804b1-49ce580c9b7mr27081125e9.2.1788343331178; 
 Wed, 02 Sep 2026 03:02:11 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B831700C106E30F6C827C62.dsl.pool.telekom.hu.
 [2001:4c4e:1b83:1700:c106:e30f:6c82:7c62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdd73f7a4sm138612215e9.12.2026.09.02.03.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 03:02:10 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Igor Paunovic <royalnet026@gmail.com>, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v9 05/13] dt-bindings: npu: rockchip: add rockchip,
 rk3576-rknn-core
Date: Wed,  2 Sep 2026 12:01:39 +0200
Message-ID: <20260902100147.16191-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831040751.24030-1-gahing@gahingwoo.com>
References: <CAEWPSH5_PmfUCEm5O53=32NQjPKMd4vm--Y2R=4ErMoehtt=tA@mail.gmail.com>
 <20260831040751.24030-1-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Jiaxing,

> Here is the table. It does not say what I told you it said, so the
> retraction comes first.

Thank you for the table, and for leading with the retraction. The
replacement is worth more than the sentence it replaces: 364 of 364
with a single register partitioning the two groups one to one is a
field with a reason, even if what selects the arm is still open.

The third value is the honest kind of catch too - a row that breaks
the lockstep and narrows the claim to the regular datapath instead
of being averaged into it.

> The script that produces every number in it is small enough to
> send if you want to re-run it against your own corpus.

Yes, please send it. One honest note first: there is no vendor
.rknn on this disk - everything on my RK3588 side is upstream Mesa
and generated TFLite, and the script reads .rknn. So the run worth
doing from here is the axis your corpus cannot test: all 94 of your
files carry the same 2.3.2 build string, and I will try to collect
files produced by other toolkit versions and point the script at
those. If 34/66 <-> 0x4044 holds across versions, that is one more
thing RESERVED_0 is not.

On v11: the clocks patch carried exactly as sent, authorship chain
intact. Thank you for doing that carefully.

Igor
