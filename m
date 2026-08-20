Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA5DC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7768110E22C;
	Thu, 20 Aug 2026 18:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XjJbEDza";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2754A10E22C
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 18:51:20 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-481595afa73so26547f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 11:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787251878; x=1787856678; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pp5J0jgzAEL526K8MSIBx0JpzYWE+QXYN3SwjN7BJQ0=;
 b=XjJbEDzaSH5gIxNmiyYQHUqdjlMvFCcZlsAiASHBwWnh34Efzc4NXn70AmQn5AIOgV
 QtOIxHcJxUFhkZuVxozftXil/DKxVyVG0xvrMQlVpoq5cxY9TxI8ZfGsgSFqGVavp0Au
 +wyurM4RaZ+92pM6LmjmJ67kWbip3TXlVda0ZFniuZDqRvw+KCBBjH6ZoXsupyROs7Wz
 LSEWmE5XwmGp+c2bjLkxUckjj+3ZXiHabQpxUmIRq7Q2hY3f2C6fWifoE7RDK7Rfb6mo
 cEFKHtYUJ0ECaamK540JlOP1DC0fCOdXleQT5VPAJA3599/tRZL8GYndwOyuS0WF6DE6
 n7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787251878; x=1787856678;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pp5J0jgzAEL526K8MSIBx0JpzYWE+QXYN3SwjN7BJQ0=;
 b=o79ZygUaUVTSYbNVDRmPAJlLPfr7rBUmMSm+nob7tWPC9iDqnyuOhHhLom3Zvv0nJH
 7tF7U0FIZ0elVT0YBGayGX2V1TehL7k3UCk1gzCvSmCyZ698Y0pqx9m/YPTF54E/wFPk
 4hAakAQRqXDxEyG1jtmRi97YA7s/L1/h3nnfTMZSOoFSqZgrXpllOrC85HZkSMfr3SHn
 Hb3mCV/vVFakeN2I3J+dE3rQpl/WYYfNcaEWedCsq57yBYew+1fn3xmgiLwedcan0cjl
 EchjQEfyHYTxCiJ1P1iZt48Ojq1f7BwUPnerexstm+njI8OcYmEcdKgVoh8IWwEDmy98
 rSMw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeK0TebpTNP1vWg5n7hlo7hFoF8wNARJl8rCyQLJEYEn+hGt+UvmyAaGoVFI8OdL9+xiwnpd9fqoM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YziXr+TzhwtqxIo5C82s2sHAb2WXMo6MWdJeNvKALmvpFza5NSW
 G3F098JU/1Pbekl9catoSum+XKoMj4NIOEjtvxW/UYQKNtAocKDOo+DU
X-Gm-Gg: AR+sD12/Z5N/d15XXduQKFqmL0nvuntvUYwDc1vqPYlzzuVl5e2AHvglbYo1hAK89v9
 8r248vYZzuk0A6voR19+k5O8sEmtU3hhYBOtvtNVHQC5XZlzkU+vPdfDizR10DkmWmliVuIVadB
 EJR7yobhcRhtyqPmcslrFRO3YoWfPY8VcAH8mz7vNEfBAOkMunkaZqKmnTByXX1AP5TyXR6wlSJ
 CbNoJj6gruh9ySLAamgEbgZp3OYAfoH4Gzr1FAZnuNZWOOu69PyBRSZJobAIwUNy9keeesPPwvl
 bWmTYxeGKyMjFNJXxQ4lfVl5CGWUTciFFdeMB4PcdDKYCQCT7fofOh4KRXS0iRogVCPZaCDsJNR
 dmQtoaALyW/WwJ51ivEd5Hbnkn+M/dFAPnbsFtar6VDDCpljk1vCF6kqJal2wb0IJtbR9JccMPg
 wp6ovv5FTEdFysGfMWKKI/0PML6+Uoz/8MpDaXw7v52WGcxWPgj+XMjUvWpBWB3DgNgbnpHw==
X-Received: by 2002:a05:600c:548c:b0:499:5b0f:72b with SMTP id
 5b1f17b1804b1-499b835251emr9349565e9.1.1787251878389; 
 Thu, 20 Aug 2026 11:51:18 -0700 (PDT)
Received: from OrangePi5-Plus ([2a06:63c4:9102:701:512e:da32:b75b:2535])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b91173c4sm684915e9.2.2026.08.20.11.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 11:51:17 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Thu, 20 Aug 2026 20:50:55 +0200
Message-ID: <20260820185056.20643-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820100715.750660-1-gahing@gahingwoo.com>
References: <CAEWPSH7ETfw2TDjUfOvcVtDm19FC43x2vP=Lh7m+XPOGptnPWA@mail.gmail.com>
 <20260819105723.632029-1-gahing@gahingwoo.com>
 <20260819154634.7584-1-royalnet026@gmail.com>
 <20260819184838.6723-1-royalnet026@gmail.com>
 <20260820100715.750660-1-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Thank you for running the sweep, and for the shape of it - one field at
a time with the other four held, three baselines with no drift, and the
honest reading of RESERVED_0's score printing after its timeout. That
table is worth more than the five lines it occupies.

On SIZE_E_1: I would keep it at 0, and I would not shrink the diff.

My reasoning, for what it is worth from someone without the hardware:
your sweep just demonstrated that the traced value is load-bearing in
four of the five fields, failing in three distinct ways. That gives the
trace as a whole its authority. A register built from the trace with one
field swapped to upstream's value is a configuration that no silicon has
ever run end-to-end - not your RK3576 (which ran 0) and not RK3588
(which runs a different register entirely). Keeping 0 keeps the value
honest to its source, and your comment saying it was measured not to
matter on these two shapes preserves exactly what is known and no more.

One question in the same direction: by the SIZE_E semantics you derived
on the 17th (SIZE_E_n + 1 = the number of 16-channel atoms in the last
bank), would different output channel counts exercise different SIZE_E
fields? If so, two shapes cannot rule out a shape that leans on
SIZE_E_1 specifically, which would make 0-as-traced the conservative
choice as well as the honest one.

And thank you for being exact about the tags - 1/13 carrying, 2/13
dropped because it is no longer the patch I tested. That is the right
call, and saying it on the thread when v9 posts is better than either of
the quiet options. The re-run offer for v9 on RK3588 stands; the harness
is set up and travels well.

The trip went fine, thank you - I am answering from the countryside,
with the same board on the desk.

Best regards,
Igor
