Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC4606A32C
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eofWCsfg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 485EC10E00B;
	Sun, 22 Nov 2026 07:52:49 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F17810E00B
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 07:52:43 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c4395d31228so365041566b.1
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 23:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795333962; x=1795938762; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/xbKBOQ+2sn1cOusP4Ybo/C0ew1hnRxWONbAKH11Cm8=;
 b=eofWCsfgd0j5Fz5RlnvGnBPU17Win4q67j+6Znrhgxo3/iw4eHM172jEdR4Q3avIFd
 Qs+lWoCMWL4HbYdocDEWLYIicTO2o+s6afG4lPC7JOMFaGuo3rfS0Zxopq1XKu7YaGk9
 0hTrL8D9wYG45RkwbI44qghp7Jzgv46BioC3IHWyAnyq2BitRQ14AwCPvwJj1sU4GLy/
 zkIcR9kXBGQO41uyNu/UJT6EqsReuD3WstO55ohvBgniUm87rJ211bWQJrpl5+3NZ8WZ
 ljTtlrNNgp6Pq564TLBPqpLThTdwseN7Vv0DtIn87W/E074+Ss9I2CbsjzP9E30IV7Wa
 d0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795333962; x=1795938762;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/xbKBOQ+2sn1cOusP4Ybo/C0ew1hnRxWONbAKH11Cm8=;
 b=MT8W5jKC6iU3EB4Z4ogmJoTUjh4oPRVKHdEn8FsZOWgjkP+jRj3O258wCalTzpi38P
 8TC+zBZqETE8XklQexu9oE/VeQ2fb1ocQ9ynElRzJuX0K86tqPcYwmWYyBAWoeHfgvQ/
 R7Vd3LqTb9wmTlCMnjlP2a1n4VEWp/p2XSmVZr5ToCoTaPGAOs3Q0rqUbtA80Zau7vNM
 d++SnViL6YXwKOdPekAGSfQxb2/GP7R+dBforP5928NzLxIpv8iR7Rp3E0ZIoqGHJLpg
 3LIlH0ufjSP8bO1AgVEFB4GxSFuanJuk3llGm9d8NT43MwG0kfVLL08MkmT7b3MO3nz9
 3hiw==
X-Forwarded-Encrypted: i=1;
 AL+hErH5mvp8iYILbk7MfVqpeh/2QN9T7NoSb63RwIJ6mpUOMnlCgdu3ajfNp7RlKejAZOW7JrLzTIuUAPU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Q7Zw0ncx4SB/NHwR87HDmnyfWWh3YqZUnPVrP5gmCrxO7oBrr
 HYxX+nzRB2iZj+A8odmpfTpPHdcGpoRwQiJDQcx7gIgLE2NRjgWsvO4G
X-Gm-Gg: AZFdTZfgp/6H+J9CLdHmqeCm/casXr8mW4JxE+/52nSwkgdZujPBSwEDH5k9nMPFjp1
 TUDdT35sGwdvFbsZKf/IdL5vX9mhuhDVChYHwe/ymQ19nYY4shNExEMyTdGvvWqGrqNog6aOHl8
 /vl8RSHRFRseglRWDsN2RvPbtaN1sH2t5rBrzGmRgNlHqbJwENiJPoDuYurh1J1a64KDUaBxbTQ
 ivRgrlK4snOzEVwxMJONNJXjrYnzxxuj3YiyIERqlTMgxGTxHhWGhH4u0kH8rvaDI+hvSWM3Z5l
 Oqh40F2NFwYIKEA1pOLuLGsq21btICXcj7jnPP32dFMqYqWCnxWW2M79EkPkTxD0YYZQf5IaqzD
 Df1bFYgIayhNAepqbWdayaDlQNX46p5zAShUEJBrXVsOk0IHtVNmpBCQ/3v+d0VQvJSkmdZw0+0
 llZO/WfKZsHg3pE7FfkRMM4LVqFVHtW+meNo4wyzfo0sskBaTHTCVmMfFhKdNN7Xu+wFHN4LvO/
 8vswRpbNq55NiBfHqun6Xvwoxxs8o1eLYbYWp3p5C4E+Wro9B/sIE5rnPTBgF06LpzxZsix52q+
 vy/0g7SjNLSygcD3/e6RXlE7dQ==
X-Received: by 2002:a17:906:2dd8:b0:c2e:3ed7:7db4 with SMTP id
 a640c23a62f3a-c513a840ebemr531051466b.23.1795333961712; 
 Sat, 21 Nov 2026 23:52:41 -0800 (PST)
Received: from dl360p ([195.155.168.55]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ad026a4sm290470366b.2.2026.11.21.23.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 23:52:39 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Michael McAllister <me@michaelmcallister.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: display: panel: add Novatek NT36525
Date: Sun, 22 Nov 2026 10:52:35 +0300
Message-ID: <20261122075235.2915534-1-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121-brave-adamant-caribou-b01daa@quoll>
References: <20261116070212.314228-1-tadilhusrev@gmail.com>
 <20261120114100.978148-1-tadilhusrev@gmail.com>
 <20261120114100.978148-2-tadilhusrev@gmail.com>
 <20261121-brave-adamant-caribou-b01daa@quoll>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 21, 2026 at 12:09:21PM +0100, Krzysztof Kozlowski wrote:
> Still incorrectly threaded.
>
> I asked to use b4 for a reason. If you insist on not to, then at least
> follow standard process and standard guides of upstreaming work.

Understood, and sorry. I was sending each new version with
--in-reply-to pointing at v1, which is exactly what buried it. The next
version will be prepared and sent with b4, as a new thread.

> > +      - enum:
> > +          - novatek,nt36525-xcover5
>
> I don't get it, what is xcover5? This claims it is Novatek device. Why
> isn't this actual panel manufacturer?

You're right, Novatek only makes the controller. Samsung's vendor
kernel names the panel vendor as CSOT ("CSO" in its panel table), but
it doesn't give a part number, and I haven't found one in any public
source. I'll try to read it off the panel itself. If that fails, what
name would you accept for a CSOT panel whose part number isn't known?

> I don't understand why this cannot be part of other bindings... looks
> exactly like nt36536 or nt36672a

Agreed, it's the same shape as novatek,nt36536.yaml (three supplies,
reset, backlight), which already carries a CSOT panel. Would you prefer
the NT36525 panel added to that file, as a second compatible item with
a novatek,nt36525 fallback, or a separate file modelled on it?

Michael McAllister (Cc'd) has a DJN NT36525B panel on the Moto G10 that
would use the same driver, so I'd like to get the structure right
before his panel is added too.

> > +  - port
>
> Drop port

Will do.

Thanks,
Adil
