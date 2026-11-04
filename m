Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33570607E91C
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HI7WG/M0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A097610FED2;
	Wed,  4 Nov 2026 20:11:13 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 301F910FED2
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 20:11:07 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-36a18fc7a38so368624eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 12:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793823066; x=1794427866; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=axktSpkMz8G9oKTbdKR+y7TQiCVf6bAQxEAR5q4VBnY=;
 b=HI7WG/M0pf2WfBPgz7XJkqPpLxkDmLtQl8dAw/nIHWWxywZ3U/86kh9IYSB/uO4S9p
 wG5xV5QOhqRAQEDR7ekDgMt06RGr7fwB0KId3S81Wthz3IKEoKxHKVKPL9HU57HvpuNe
 WQorkwl2vIpRqgBVgCoOGQKRwmVMoBFdyreu2++AUrIqsw0K5vfHktAUqjnsDXDNrz7y
 3422GsqQADisV+TtVHd7l8t+72k7F5mrlU2lh0QJfss615tJ4AQ9zgzdwxxdASEWj5yM
 ekx11lH7hNCdFB+0v5EHX222XR0+TuLdTRefeEjQ+OwIInFH99tYjAAXLK/zn5P1zIdc
 NS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793823066; x=1794427866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=axktSpkMz8G9oKTbdKR+y7TQiCVf6bAQxEAR5q4VBnY=;
 b=hhuktxMqTxLH0TrtXqqR98tIcmBiQ3OIGDHQ9vp/GGg6Hn7VmgV7BPr5GtB4npVr8G
 7qg787iAS4zOCVAjR6R+EP6ew0Rh9ds8wLW6YDaneyQm8cFrUAq7xjgZdbCJkpTuZ+V3
 oVfsduQttRZVyBZW81MfsnuUJDgXnIUohO2BOZjHtqCk2WNlYZj4akhs4cmjwKry2JNM
 Wg1LwlQz1ZXCU7nYsTuFTmvOn1vmZe69Td8LwnKbS6OCi4BP1+MVqAtIaAZopagoG6kK
 luh+2e8eg9BKLYUPYPIFFweGNa2KlGrpxIB99BOvUXB8d+xVXqf+d0eh52RDt9AXtLoV
 HSfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzH0jD/oCNgvxVbd0wuqq2ePI8ZCLM4vF881plnQ0VdIYmWAIKOUBiARMnsp93Qlm5a8Cl4HwJxeKU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8MR5OUrFs2tmh9c6rA//7D+RDJEOG52GZeLX/9diE6gNKh5GRS
 ytIecd6XJbbbKPyfG3O4uMbNgFD3Qxh22ySCRrMfreSvNtJEMFB95FM=
X-Gm-Gg: AYBFou3buPg1SJN842++LGe8S9jXUCc/8YJ7sK49q1bfZWA6UHT4bAWLQUUY05ddNih
 jqklMRjVIHiP4rDBzDAfoVHNZV3yYugVGZ/kkCy+v0NuTvbJlQjYnpdfAtGrO0Ty41L+hN1cFO4
 Ao+3dvuuyDC4ES9cutIdflo8xqK/JrkhLnVD4SmraOpYnZuedDn8U5yVhHQfOo+QxiU5MEiNCDk
 uv6DhVpjCYYUcahnJF/wyrYRIRxD9ezHbrXNAG3m7sqZGSavGpcTvb41e0qPz5JsD/9KKMi87r4
 ql+UtRqyUJqojN+ZmyOUiLqqYoT1xvFQA24QEjptoxE1fMVq53tIpBcsTqR+uY5pFfbbfe0zzXp
 xsGEKRFIHFR2cGq4kLNJdwIBl1yk+s419YNVLrFCXd4qe0+JPcioguHRuOt4v64V++KwTTO1ccY
 nrnbEex4zpSKoLoWmjFWHVDRzTQM3V1l/yfgQGBxrQwRNrB6/H0Muiwkdu+yCXd2InebpgNpTx1
 r28z1vE6aQ+bGcNSghbaDl6P6kx6dq3JQn8hQnkYbcU9nbnqi5j6/bUe4unfDxBIo4iRh7+oPsv
 Dz2+pOGo9TxzVE4pZdO6DAj9z6KvGA1DtbBxbeHmFoivkxEVXb6jKZgVfJMmQOJV
X-Received: by 2002:a05:7301:2a95:b0:36c:9afe:fcd8 with SMTP id
 5a478bee46e88-36c9afefe8dmr5613420eec.30.1793823066322; 
 Wed, 04 Nov 2026 12:11:06 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36dd7ec8881sm2731938eec.18.2026.11.04.12.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 12:11:05 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: alexdeucher@gmail.com
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, atharvatiwarilinuxdev@gmail.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, linux-kernel@vger.kernel.org, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com
Subject: Re: [PATCH] drm/amd/amdgpu: Add 5K Support for iMac20,1 and iMac20,2
Date: Wed,  4 Nov 2026 15:10:57 -0500
Message-ID: <20261104201057.8395-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_PjiWHEDzS5DJgB1wS72_tHp4Ju5Wwr0R0N5EK-i9fXfQ@mail.gmail.com>
References: <CADnq5_PjiWHEDzS5DJgB1wS72_tHp4Ju5Wwr0R0N5EK-i9fXfQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

> I think the rest of this can be simplified quite a bit.  I'd suggest
> rebasing this on the other 5K support patches and see how much of that
> code you can share.
> https://lists.freedesktop.org/archives/dri-devel/2026-November/610011.html

The code that i saw, dosent have the ability to change resolutions, and the code
it self, is basically completely different, for example writing 0 to 0x4F1 completely
kills 5K forever, you cant alive it again on iMac20,1 and the code does that.
