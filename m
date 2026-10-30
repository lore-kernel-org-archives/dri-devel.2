Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F83606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hKSRE8Q9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E53D1125BC;
	Fri, 30 Oct 2026 01:17:02 +0000 (UTC)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 413831125BC
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 01:16:55 +0000 (UTC)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-3ac91ac8924so86626a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 18:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793323015; x=1793927815;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
 b=y+4EdGhxqm7nBsr2UzZ2vFw9WQV2bm+JfdSkOJ7j8pJtkKJzlaPV/Mc5XbBtVA25UL
 qZHcO6U1TDou5U96RT2RDdWWFEqj+APJPfal2vOf6KUNtnGOs5rHOKVdxPMWeBR0RowF
 Spg8hslP0IlwvixRf8UP9b0J7G+5CneLV/uKhPgfYV9HN64S4acFv7HThxPfNuhLxwll
 XjpQZFZgTia0+a8E//mLpWojahCebOi5g09eps5kCS8POdcdfsoqBATiZcVzbexWuyD1
 AStdvYGxOLx3mXxd8hoZgxqQXAdKoeJ6A2v0v/r59KlQWCaRLtUt94zV7Kx6glt0S8nH
 0D0A==
X-Forwarded-Encrypted: i=1;
 AKwUvByk3yLoPyngeuvSxNmyb6220hNUb0cUQ9BGGk1d+7rg4GcQiRhnDHnxmi1QzcqCzWSUfv94P8xZ10A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIUliS7zkRuEdZMmOT7ED7VdHJxNcQtqyJxFJNFXEqA0VU3lybJ
 z/P7h0/T1cj+PgiKiZHPt2Indmz/jOZ+Az781HdReXsc1ZMqkcJOV9AVLjS7wLl1m3+D+YmTpKb
 CAEimHz6ja6wXhPOumTRxzCxjsscd4ewmWu9r2eTZAJeegcddOvI99bKk66XisiEUP7DGsZJkQ3
 J/bC27InxV+FHtplV0oSZZLRAi00lJsJfJpPRLjFSxBY84LlqcmJw8071g9h+lpWvZCIhFIwWZt
 ohXmb2Am9VI11i1zawAWvgCvmd9
X-Gm-Gg: AYBFou35bKOV4GdZHSLqs7kT5u9/rJZgDXTZ174oN3cEweV/BHG8JQqkbkK+FKPGvoI
 Spor/eVcDpL5vnGRMN4YNtFpWO5dn7fsk0yb1YUiACOtrm7vbTJI4wdtBhAi8iBoTZgt67YzCii
 nJX16g3KDlcT18Jv2GoG/ofsE6xW3CxuXy4qkjsCgUmWUw56WdjmZ/ZNGMIzUnSzwHoSudwBxOL
 UudSE/pUNuyLX0q91ijdvCOflekDX1fIJ61kmtvdrAU1Gd6uWZHYx/EW8HmfW/KpGIpH7Rd/Cac
 Qjj3QmrCxCAwLIhbapoaF8Q7vla258C5zfW2VjoD55piQ8e6F9EMT6m1oGf/gsm9rbOIeTelx+g
 BEjyZ4txQUdD4Ay+9J/9GkFsn3XEPASXbkKN3UYr1JblMHbvTRm8bW74iRqK7BHbOssoCGlMOjZ
 KeH9VjrHoedObdrg/kzmmw0D7Rp24zBEgXCd6CTVEo
X-Received: by 2002:a17:90b:3d4e:b0:3ad:1841:6f8b with SMTP id
 98e67ed59e1d1-3ae8981e41fmr542594a91.37.1793323014673; 
 Thu, 29 Oct 2026 18:16:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ae6e6ec859sm3191951a91.2.2026.10.29.18.16.54
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Oct 2026 18:16:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cbf2fd504so26644385a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 18:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793323013; x=1793927813;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
 b=hKSRE8Q9pUGX5HNk7eh3fws6XKi7tsjWA1jnhAAfBkBm5p7yknoTIwcEkO6+W/qiuS
 JsYRXNwVccEWAapjmbPcO/KUVJcllG0OESMUKgjlBup6HFoje6nS+LjfqIXruJ+WTGtT
 +K8zTmbqGrFmWhyYfnrtd3t5GS9tKeztXHi6U=
X-Forwarded-Encrypted: i=1;
 AKwUvBzYt6heitREkhUJDrH+93sJdpeC4Zki2A+UUFQrm1c0r/yFom7/4CienSWd/gVKrUDaQiRNoOkeQH8=@lists.freedesktop.org
X-Received: by 2002:a05:620a:444c:b0:93f:322b:2209 with SMTP id
 af79cd13be357-944216ee8f5mr158765885a.28.1793323013528; 
 Thu, 29 Oct 2026 18:16:53 -0700 (PDT)
X-Received: by 2002:a05:620a:444c:b0:93f:322b:2209 with SMTP id
 af79cd13be357-944216ee8f5mr158763885a.28.1793323013008; 
 Thu, 29 Oct 2026 18:16:53 -0700 (PDT)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9442581b2c7sm11353985a.10.2026.10.29.18.16.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 18:16:52 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 18:18:13 -0700
Message-Id: <DMHRZBXFHC7H.1WAJIWY0I99QZ@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/vmwgfx: log missing primary planes only once
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261029215540.3008997-1-zack.rusin@broadcom.com>
In-Reply-To: <20261029215540.3008997-1-zack.rusin@broadcom.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

