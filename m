Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68964606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=EVyJ6Hgd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=NpcNJfgK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD4210F032;
	Mon, 19 Oct 2026 16:16:28 +0000 (UTC)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5037310EFE9
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 16:16:17 +0000 (UTC)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 6F1297A00D7
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 12:16:16 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
 by ams-compute-02.internal (MEProxy); Mon, 19 Oct 2026 12:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1792426569;
 x=1792512969; bh=twMOlmT0yue23EXrb7yO8rXJi54Hb/dfyyQW5AH2AG8=; b=
 EVyJ6HgdPMKC6/xmfmw41oqqUK1u/frW2CBaRMXMxMuY+4xGRtcvhDkfauDKa+Rw
 TN/1IdBVxghQ2Mrl66pkIScht1HerkvW9F0mGq1Rz94NUXpn0XV+Plju8m1rTFgc
 h33BcCxRHTuSLeHAima47rtWSOROgEOGgEkYNLlNSlry6s3zPk9epS35/TfAN2xK
 XKzaKU+4cSypEoeD9wrvDbpsOc8L5q1Czyez7oIhFFTXLqZX0PG3YYv7dO7uMm2W
 8T++XKzsRlKAcJSV4v/oZLTVbvrcDBOinaOPhKGl+WyjlvWqD4mCioYk9bbiOfU1
 XmSnbuXBbKcD5HN699CcjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792426569; x=
 1792512969; bh=twMOlmT0yue23EXrb7yO8rXJi54Hb/dfyyQW5AH2AG8=; b=N
 pcNJfgKpiGDU2DQd35qHaUjGpHlhD3L9AU5l04ha8sM1cEcJV135z7dDeTs6L6Md
 gHU489aKgTkdGeO753RevBDPOaNa3bgGbq5D1qqzZCY6ECcdN8hd+mHlz1nS208X
 Djlo1aPzJYynU5aTxNBCb47tGR8xbdZD0xum9BJcjeb4pBEPHJ7mTWyKmeqD3PUQ
 8VhDeaToQPTuPu+MCQqSPXg0Dc549+YFD97kBgK19Cr6QaKtQREOp24a4JEmRNGJ
 OG/RqOLSlBGslnyJmd5J4i5RbCZyBmWUHlDgzgySD/lAEeKkyEzZ85fTh16E9MAP
 1OW4XbJWF4AfkMYWhDqrg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792426569; d=arndb.de; mf=PGFybmRAYXJuZGIuZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:hoOXlUTXAFK7fvsIwqb+CcFlQzUthYUM0T3E+p4aSIEJwHw
 t5GnHvtI4RrnqyqdlDbdvvgA/anOVMAc50ONXV2L2pEsHnn8XPuCMc1q34GAAH+i
 63ZlL+q1br84XYvIHgKS8Xc6fjiVeONavhFz+PKYCte4WPsFIpKVx/gN3PYZbPcK
 PvT6oZrYtzqn4Vep7qapQFAM7SQI+h9DvnlMhWURVBD4/iIPAQ25OCO0lUUgGUwv
 /i/WBvXTde/NYYXmD/12moyvNVvxkd2wcWgMuOFxDbd9kcFQ+urs4gQhQXfFJAEA
 OpeghhUifPsMYUdYe78fVEGUcF1CYaoJImFeTfw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:VNN01YMeoBa5EVQZcUhpH3ntchpaAZTH7HsXvobRRs8=:He3NBNHj6wh7LN1DoAA+b7UitBww8Jtib5MHhm2r6KE=;
X-ME-Sender: <xms:RELWaqUwoqf9zbQUn9Wv3_JUgctuFYyLX_dRi2joRRAwTXcPNQB_9g>
 <xme:RELWahbIbeHvYMHkeD-ouRizEe7Ijw5FHQs1CsnU32g3ghUaOCBuVN7VBuO9wHMth
 hstvP0CuejOj7k9O5YsjJ3V_oaibWE1qDLBuNtp-MVcUpetzuXeB0c>
X-ME-Proxy-Cause: dmFkZTE/YABC/L3ImVGCsVMwCnE+rJ7lv+dsfJO2rPmmgoXH13hyWzswO/+2INr6Dds1sh
 zhXBho3SOfk9G+qngnWHyX6GOpa34tm4UQ4FWBJ+iZEql0brIlMjtRlze901uO59SEmtOL
 CNUCaJeYTctECI8ktFcbM6gHKx/AxKuUWkyMqodPbP1ckZ9K02Ej9svP6PgpQzzNipcAZ/
 F8Pojc95eXinBUoI5ie+cNaLM3U4jJp4zPA/2HFX1uthTWUhZdiLEZ/D81t5mi45H7sj0n
 577RJmK4PS6+q3ZMVCPLMYp/G6Lt2kS1/Sa7037xFKn/b1r+B6t98FMgBfwBvlUqCNuppQ
 S17Sk3+Fh4lUuMJ7eMDTjMHfNe9G4hyeozOgjELwxKS5ovIrSC3tqqFJyx3oifgenZOTIr
 8N53K4bWLub6aDBf52y08I+ahjbU4qnPC9kJmLaHxAzWn46ctIxgnH9JTwjQT/ZbgXfZwg
 uOR1xUnMLMPA9IAkgnvFNUI0PTaQP5GvlSMQhzFtRZh6BL4GJ5UOM1qeH+rofgs1jvhaXY
 9D2cc/o+zEv+s0KDtRBr0CndQhIehHNrlqr9NTmH2VtOU6QSUBX0yUH1fWHnf2IHkVQDR3
 U/Ke9kqtYb5IKTgSUziph4D0HrsrdktVa5NAfz8MjCfTlQTBz46ZFfYeXbCQ
X-ME-Proxy: <xmx:RkLWaonu2AWyhmTBGWSgS_wyA8Uc3mtMoheCRzDMSCYsA5VfovfHeg>
 <xmx:RkLWariZvrXWgaMY5tK9EGRfnOwleyN16x2IjyPjHXNYPEtbOq-T5Q>
 <xmx:RkLWavQQWq0jpBPClH8lFz45vDkkc5J8rxbNkKe52pD6XmcyvVHDnQ>
 <xmx:RkLWal-3BCSVCPrEsAU2g004lLbR_piXWpJimavNfF8brlr4xSsnSA>
 <xmx:SULWaujNODSG_q5KW8LRGLjTAicq_4nusiuCaej-avpWoSTeKiP3JzCe>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id 18E6632A008F; Mon, 19 Oct 2026 12:16:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwmqQQkeUF_N
Date: Mon, 19 Oct 2026 18:15:43 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jani Nikula" <jani.nikula@intel.com>, "Arnd Bergmann" <arnd@kernel.org>, 
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Dave Airlie" <airlied@gmail.com>, 
 "Simona Vetter" <simona@ffwll.ch>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "Chenyu Chen" <chen-yu.chen@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>,
 "Harry Wentland" <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Message-Id: <3486e0b1-d188-47a9-9de6-7ee5c2cfd097@app.fastmail.com>
In-Reply-To: <6c18da11310ced4a7c85ac7862c3f5c67b39891a@intel.com>
References: <20261013205223.2396822-1-arnd@kernel.org>
 <6c18da11310ced4a7c85ac7862c3f5c67b39891a@intel.com>
Subject: Re: [PATCH] drm/edid: reduce update_display_info() stack usage
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026, at 15:28, Jani Nikula wrote:
> On Tue, 13 Oct 2026, Arnd Bergmann <arnd@kernel.org> wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The drm_parse_cea_ext() calls into nine individual parser functions
>> based on the data format. If all of those get inlined and KASAN_STACK
>> is enabled, this can explode the combined stack usage beyond a
>> reasonable amount:
>>
>> drivers/gpu/drm/drm_edid.c: In function 'update_display_info':
>> drivers/gpu/drm/drm_edid.c:7040:1: error: the frame size of 1888 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
>>  7040 | }
>>       | ^
>>
>> Mark all of the individual parser functions as noinline_for_stack
>> to avoid this and keep their stack frames separate. This reduces
>> the stack usage for update_display_info/drm_parse_cea_ext to
>> a more manageable 744 bytes, while each parser only adds at most
>> 200 bytes on top.
>
> Is there really no way to tell the compiler to not do silly things in a
> more generic way?

The problem is really the sanitizers here, which turn off the
optimizations that gcc relies on for its normal behavior and
which cause additional register pressure for the inserted function
calls.

       Arnd
