Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361C010987A5
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600BF10EAD5;
	Fri, 20 Mar 2026 16:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="E0KSujl9";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DE7B10EB58;
 Fri, 20 Mar 2026 16:41:48 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 148DA4E4274C;
 Fri, 20 Mar 2026 16:41:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DDCD9600E0;
 Fri, 20 Mar 2026 16:41:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EA13910450CB3; Fri, 20 Mar 2026 17:41:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024905; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=VTzg+gCn+3SSyvA2tJAFWtV2tz8sGnFVCym/sblWN/8=;
 b=E0KSujl9jeNWQO6spEA+e4SRvfV796T+JBzLCmDud+I6xDk1XQAkFI8xslAtxw8BOzvloY
 bzZa+8x6yg3SybdwPwmZoX8xoJyqIGez1HUTyv/mlmDBCFgfnPU1xv+4QRczJCAQTrxZjq
 ctWQ7SSks7tEY7ErvouYk28yP1YjajzlE3Q1N3NuyN8S9K1IdfG4dpLogNlXwUDgXcqK7i
 EXTo5qF5Dhqu8ylJ19UzA220WcMOH1C8g/+Dy3/iH/K6shpSoJnZvU0umjtUUM0SNMyN6P
 JFcUasH/1CCdLlCm5JDoBI9HADTLIEO/MXqDOen5xanR8tmUh9/pS4ChSNPnkQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 15/65] dyndbg: macrofy a 2-index for-loop pattern
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, 
 tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, 
 jani.nikula@intel.com, ville.syrjala@linux.intel.com, 
 christian.koenig@amd.com, matthew.auld@intel.com, 
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
In-Reply-To: <20260313132103.2529746-16-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-16-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491430.6181.8634650505959510277.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=569;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=pdrjqLsFmHIbG9X3g6woXxeUhicJJyV9EoUqHZShqbU=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjW6jY+HJ/rjDVPgQoNFIF9TaWBTui1u7hFy
 Yq3XSIZkg2JAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab141hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOIK8A//U2rZrLMs+ef3C31EeZ3hyLrARRM4H4N
 AA/QpDwgkx3Fpec45T9+rRg4DoFCi80urNIb1j97UMT2W6HjFujCC7T9pbVw8SbJGiNnJJx8BVu
 3mxpa4mQDUQ6fJ/mr6IDQ4A/BtKo1i5VEnjA5/O7y+jrSsQNeMx8MSKIxdmS6kYurUpQqpCfwvg
 TOPXweWL4sKjrXGsmVfyRFE8r52ahnf0EzL0nvaGfCuCRP+CN6yWjbNhFH/9EMhyaxUx2bJy1YN
 aL9I88RxlcPg/RhqnCUkKOB6pGaRcpkfEWiX5hAcTzzr2ZUWvGTg1RL+nWYN4+Wu8D7b0wJgo83
 hvl6GeBNfm81gqRMyoo6jXJ6Qjgy78mbpC0gyjR08UyW9h0oTn4WJggSjZZyfEYh8THil4EDN77
 cnjPtjiESL+bOWJHNPBQAXzXHV52LOUKBITABsOd8Ypn/ZzWdBg9Qwc2lhFn8zCXf2mgkhAlNlU
 BJtwk2EOrJAlINz4zYmos3m4vGURSIMg07v4vcUVzG/DSfEewsXmOFHyRfnMa4ZH0fUiA/afx82
 14kSQt4jnWoEsj+7ro1GEuQikBOBRQDtM00PEFT9Yb6hOdsK80xSTez5owT8uyrj3cZbyckghuK
 zghhiNLWFAe3uV/hiZt2JW0WF5QBxg+C0oP0MFOEZKxai5m+UyrM=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
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

On Fri, 13 Mar 2026 07:19:40 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> dynamic-debug currently has 2 __sections (__dyndbg, __dyndb_classes),
> struct _ddebug_info keeps track of them both, with 2 members each:
> _vec and _vec#_len.
> 
> We need to loop over these sections, with index and record pointer,
> making ref to both _vec and _vec_len.  This is already fiddly and
> error-prone, and will get worse as we add a 3rd section.
> 
> [...]

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
