Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C27606A331
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 05:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Z+zEPo7u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF47310E3F1;
	Tue, 17 Nov 2026 05:14:20 +0000 (UTC)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC0C410E3F1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 05:14:13 +0000 (UTC)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-3ac78f4c10bso2208204a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 21:14:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794892453; x=1795497253;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SCfz1f0OOAQVJN2xpcPcFGbJPw3mdu0gWKPmT7oxwLI=;
 b=ClEDRLuzt0R4i5esAmNbtQOj5jSHsZ6Nqx/6WfVClpifeVrxlrm8mQTepREjxSHcRK
 uf/AZM8jV/QQqXYCTaylA5TXJp9ESy0ZsJN5d9oIqiUnCKdJpJB+qWKIHmdidmRXbkwg
 5NYcusV6pZEUiS9TkkvwSyRj2JrHU3N9T1aVzQK531j7SHfbvORKj0fOoiKjGnBkPrad
 auIgxOMWI8B3lCGjotcSXrNttNO17w0tnOrBQ2h1IepKRG4wYYc7K6Fgf/TdB0gsVHjV
 zKW8luHdx8RmPKoYQ40YcfN2rIAUfQjzf+qe2qXmdmy0+v23w2NPPk8jDNCyQ+xn1eXt
 P7Dg==
X-Forwarded-Encrypted: i=1;
 AL+hErE06JUlDbWR0zui8eFnLUoFEfLggFAtQvZhLryk2L0Re9knjVDQGqtyuUMswbWT91i5b+wZjgQUaiM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/KiCqXtD6yIny/TU2y52L6gWbgDQLTdasobFFfVbzKhVEb9gUH
 p56uSNNEzoYvq5DKlwTKYnVPtZEttyYBhWXhC3MPW5k6Huw5U+D+x/8kWvkceKiO/EohirBBhjQ
 dPMTIGW+NUahVX3eO/JatABeuatlK2PdGHn3sSLTXWu4tjVZPsydAqJnWSu8VFLmZUcy59R5FlK
 oIL+aa1BTHc+K2U+nVzE7iSDXKafBqCp4q6Ug0LTYhbqB+KFqYt+gRnSlOuL5+9X+DOST8/hSs7
 Mhrr5ip8klz3ic67fqe
X-Gm-Gg: AZFdTZcQnd65w+yEkNOxLtzahIQ4qgNSnSWGtYvvnqDE2EaD2sx8YzpeAueOSGHX7ic
 LjoxjWBOrONQg2L4H9d4JRPMK9M0uEpVY4Q5qoopX4dKmyQyIpeL3VQei1Tx1OxG+biRT4Fzm8k
 Gp2D9OO2cu9XUNHjXRYPypf4YF2QvoO77cyToIE9HosImaGAHNmVfOpmNJeKwRwXETA+2rgi9H1
 XSWuhK8uabL1pFORCpPwLj/pEBJG1Xj62M9T5EgS/7AyIL1P8aflOt6/MoYuonXAICqHIaT5fx+
 RADbVrRlj+p+B0K1IE+KZYsy5HPbeGGL3+yGDQqzt5fEe0GWiyO6eh3CBym+0RKgan1a8CRkrax
 Uz/ppJZCq51aLToum63ZfjGd8q2vQvzZGRjZAd+QdX70xxvduDhSYGp4Uw5vafg4s7lduFXvq/h
 J7ru0ShAqRXf/b7x8c9dmHvdiWwdyS36L+
X-Received: by 2002:a17:90b:5110:b0:3ab:1b1c:8a70 with SMTP id
 98e67ed59e1d1-3b1b0b68e6cmr11813316a91.38.1794892453360; 
 Mon, 16 Nov 2026 21:14:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b3af69e8d4sm346981a91.2.2026.11.16.21.14.12
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Nov 2026 21:14:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3b3b0ebd98cso376256a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 21:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794892451; x=1795497251;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SCfz1f0OOAQVJN2xpcPcFGbJPw3mdu0gWKPmT7oxwLI=;
 b=Z+zEPo7usbkpX16Jhre2wN2MfesCKouHi2hh9SUTM6nytQE/FIBcBSvDhosHdpDT/R
 JIpDO2Y5QZlKsc4BdlpzCniF6K7s6xgHhHO49eoezI2SvO6abpFwi+iGbvrYgkK4CSgr
 ZeAy+l1k4WLJKfZV8Sc7ZVKma4l1oKR/AVkyY=
X-Forwarded-Encrypted: i=1;
 AL+hErFgu9XiYhkoUkQ0++E27fkL0lMcGWevE6Ix8XK7Oqh7LdDr8rqiOWlE6pW7DiAbsibes+n7n5PhQrk=@lists.freedesktop.org
X-Received: by 2002:a17:90b:4b12:b0:3ac:9d14:feb1 with SMTP id
 98e67ed59e1d1-3b1b0b87a53mr12408135a91.43.1794892451143; 
 Mon, 16 Nov 2026 21:14:11 -0800 (PST)
X-Received: by 2002:a17:90b:4b12:b0:3ac:9d14:feb1 with SMTP id
 98e67ed59e1d1-3b1b0b87a53mr12408109a91.43.1794892450642; 
 Mon, 16 Nov 2026 21:14:10 -0800 (PST)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac2550e1sm2060878a91.3.2026.11.16.21.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 21:14:07 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vmwgfx: do not hand the embedded sg_table to the
 PRIME core
Date: Tue, 17 Nov 2026 00:14:05 -0500
Message-ID: <179487959551.2515856.12728307164349809612@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923122601.438892-1-qwe.aldo@gmail.com>
References: <20260923122601.438892-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you. Applied to drm-misc-fixes.

z
