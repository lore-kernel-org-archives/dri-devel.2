Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB8BC982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D70710E816;
	Wed, 23 Sep 2026 09:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="QEbIjIMC";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-7.mta1.migadu.com [95.215.58.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E38C10E0A1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 09:15:31 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=oaTRjCWZnQNokZg4Q89meVlVIFu2T26bZQvvNaVlNs8=; 
 c=simple/simple; d=cknow-tech.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790154930; v=1; x=1790759730;
 b=QEbIjIMCnk1sQ73gumwPQOBIS8aq/erpZ2gQABiGdIReV+nKPbhCb1JEfiQJ7Ujljjej5HQA
 Qh4qROVxBBGavLkjo+cwll/ou+ei7uMUPtTZq/TtctQ1Dm+QO3TiYmLVSjJ1jxfaIpetdUpcdcD
 j6tX9sE8sbeUiviKhMoxBaopBJcdAQtgXn0eGXu6VK/BbMF88xrtnY6KJ/6LlX++CNOEqrFoMms
 Uz1dPZVJ+Kd+RjZXz+bnvBOEEk0M7eGW7yVZ/4oUqSaaDSTdjXiARbK6F9wJ4GYmvpS84zx9A2x
 3UqsBTY4qyCyYqbjVNPtTAC8XSXtQM94eMZP+ocw59xXA==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 342944e3381b851a;
 Wed, 23 Sep 2026 09:15:23 +0000
X-Mizu-Trace-ID: 342944e3381b851a
X-Migadu-Flow: FLOW_OUT
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 11:15:22 +0200
Message-Id: <DLMKYI79QQRS.28Q4ESQ974BU@cknow-tech.com>
Cc: "Tomeu Vizoso" <tomeu@tomeuvizoso.net>, "Oded Gabbay"
 <ogabbay@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Jeff Hugo" <jeff.hugo@oss.qualcomm.com>, "Robert Foss" <rfoss@kernel.org>,
 "Sidong Yang" <sidong.yang@furiosa.ai>, "Diederik de Haas"
 <diederik@cknow-tech.com>, "Sebastian Reichel"
 <sebastian.reichel@collabora.com>, "Jiaxing Hu" <gahing@gahingwoo.com>,
 "Nicolas Dufresne" <nicolas@ndufresne.ca>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Guangshuo Li" <lgs201920130244@gmail.com>,
 =?utf-8?q?H=C3=BCseyin_BIYIK?= <boogiepop@gmx.com>,
 <dri-devel@lists.freedesktop.org>, <linux-rockchip@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 06/11] dt-bindings: npu: rockchip: allow DVFS and
 thermal properties
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Igor Paunovic" <royalnet026@gmail.com>, "Rob Herring" <robh@kernel.org>
X-Mailer: aerc 0.22.0-24-g39041fd9f179
References: <20260922080114.44662-1-royalnet026@gmail.com>
 <20260922080114.44662-7-royalnet026@gmail.com>
 <20260922160602.GA3529337-robh@kernel.org>
 <20260923085755.16219-1-royalnet026@gmail.com>
In-Reply-To: <20260923085755.16219-1-royalnet026@gmail.com>
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

On Wed Sep 23, 2026 at 10:57 AM CEST, Igor Paunovic wrote:
> On Tue, Sep 22, 2026 at 11:06:02AM -0500, Rob Herring wrote:
>> On Tue, Sep 22, 2026 at 10:01:09AM +0200, Igor Paunovic wrote:
>> > Assisted-by: LLM checkpatch dt_binding_check
>>
>> Drop 'dt_binding_check'. That's expected/assumed.
>
> Will do in v3. By the same reasoning I will drop 'dtbs_check' from the
> two DTS patches, 07/11 and 11/11.

Doesn't the same apply to 'checkpatch' as well?

Cheers,
  Diederik


