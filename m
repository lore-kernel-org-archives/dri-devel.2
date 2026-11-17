Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D00606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=akVuYUqC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1EF110E598;
	Tue, 17 Nov 2026 09:45:48 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CBEF10F5B4
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:45:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpoO9LLK0j/qZGabXvDZhvUQgOim2gutLxqEnsOesM9vEDH1fe/F8A6tRUGkj/AI5h9fYWF09bQ7xEa1IfK9oUKJXtUH7PQlwgEpn+Oxx4MjNkkGxW1adbkm/26fUvkYJ6OKouX2Elreanm3lD2H5CKYg0HIH4fWUV+Jd6XunelBkDyBRZkWQF+sTBMGzpALMdI1DmH6wTN61EuE1ZzpELhkXOrzycCroF2qQ6FIufvSoBBHbN6yM52CZC6fwOqGX9Ld5YpR7UlCqlk+Oxfi6D6oFW4rHL32s7ONq08plrUWld/QGqVygb0BE8UYY1p688f780r2420HGhsZ8888YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfmger6MPlo4eCj1c6eCzACc8XW2BEuZdNK7bfXqOZ8=;
 b=Qv8Bo/h3uQc5wCDEEQp5q1WoR0KfWQ4TEOZu6u/OFfgytmyPqRruiHNADTeOz1vYgOWp/fz9zeuE9svSOoYWYggWG2HSd56NnVOlhuanLzbjI1xN+wjRqW0/kAUYG0qmErvqUFdIr91WiWpGvfXf7is2javWPsGkTg6Kd2ZOm1pUKCgjli4l/9FYG0snvS8dTRYw3X2V83o+qUywfiwuxs1RkV/n1XovX0mCqA+KBMMNBWWCF7o8pwobOHq5Y6ArLqJoj37wX7vuMLoDHxKZNsxcLxkD6hdNgP8J0FgIfeoCg4PzFs+LGu2xVIzv+hNquRZI7zTwOanWdiKiDcXsHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfmger6MPlo4eCj1c6eCzACc8XW2BEuZdNK7bfXqOZ8=;
 b=akVuYUqCo4oMKOpYFesmsFUFVqSNNyXJV4nb9PF8OFX3lN0u5HzL2O2P/OjH3NpXESxTPPI9DUUjSjTClKcIbUIXv9TD4Xzz/K51SAdr9K8v4mB8W26T8f8ZVCnzXEl3B0IB8upVJx9niN4q1Qm5crEwnagjyhKrbfNw8d5NyzaeV8PjP+fmHmWLx0drPQd6w4NzzA4zWWeo9RiE5qn4ciNzYMl1KvTejK2lfAoqFj0zBH0JWz4IbW6tF/xgnkrr2APpZ0O5OvKRrkFKaG8dfkPU6JrEx292xXwZhUVWyDiA7AcdcnqbAPrgpv1p3LZwo0JJ4cGmuG5Laf3DSrP9oA==
Received: from OS6P279CA0007.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:30::8) by
 GVXPR10MB8842.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1de::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.7; Tue, 17 Nov 2026 09:45:37 +0000
Received: from CPH1EPF00000525.eurprd05.prod.outlook.com
 (2603:10a6:e10:30:cafe::67) by OS6P279CA0007.outlook.office365.com
 (2603:10a6:e10:30::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 09:45:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 CPH1EPF00000525.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 09:45:33 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 10:46:17 +0100
Received: from [10.48.87.178] (10.48.87.178) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 10:45:32 +0100
Message-ID: <7bed2e64-c290-46ff-ae02-60007af795a5@foss.st.com>
Date: Tue, 17 Nov 2026 10:45:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 46/83] drm/stm: Switch to
 drm_mode_config_create_initial_state
To: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Simona Vetter
 <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
CC: <dri-devel@lists.freedesktop.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Philippe Cornu <philippe.cornu@foss.st.com>, Raphael Gallais-Pou
 <raphael.gallais-pou@foss.st.com>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-46-1f58d1e33380@kernel.org>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-46-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000525:EE_|GVXPR10MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: b844d57a-649f-4581-c9a9-08df448f8649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|11063799006|4143699003|56012099006|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261021135927099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: k+eXBh4rNwicUFHEkZPNJnwW6vpVy9ikKZ5DwUk6W++TNgHOFvkp4odkJoOCs8HIFOqJWHRLoEc6l782jfouAak9Bb2il+XMpgnR3nk5mnxMe+K+Jb2erqZi12L5BN91b9HntktdMJbcj1r2Dy7QqwslarhbXxNxv9nVXaphx5Djj6WiM6tll+tQ+jQTCkQCT08RDFGDb3uRwLMEO8jLVHzeYhOzqTECl7IBC+XN0gYfOSD5dTAAz60v2BY4dMsgXOOMj6CkVovxzp5MnEfXuJFoYXDRvJXh4g3dH/iwqZgigswGJncgFPueu1lCOk7miW4wjAU/ZSXDO2HPxXIXQ/0Ffc9RbvKWanxjcKDkueL+O3y75GgVhj7Ul5gwqFiSzotRkc66stcr6sEHHAwE+w3a+6Z+h8wYYTJuJaWxOCEyn/Y38nJtmYvZ3ICZBtaEKYuT8nu5OPXUQoNUD6FQRdE5trErpIspESBXwoqYx/7hggUPCiwFKLMdC19SPmiFB2f6kMwba7y78iYdHdzAsBxcPEFnJv9bfz2XXz3+6LdhbscmHewAnPbPpHnjbhnrsVi2TXfL0Xs091+ECrSyEyJlg9k2Mwgk/KImeF1nK1WJ0/uLNlrhBhnZw9vUmTQDnmJ1XU1fgS5CXAVlxnS0gE7zX7ZvzsyLUb9ShQ1ePvJMZjBpCcT1Ou+m2u2aExO6JW/wsiBW5tEvjxt+JWFjkQ==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261021135927099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NRvIXvOAE2gQ5MgO8GSY1y0EfPUogeXaIVKfepZB4QERbP/iZ/fQ9capv+MKMJbIG3e+0Qne/0FyklGK82IshKVsi8JwgK0TNJXwMO2JxFVbEZ1x+YCunje/GWoUXgFKmzmUKMcaADUXpog4NgGHcO8n+T+hfiYedNd0gkdXxlkDSkzBoMuL7Y9+HOdJgTHhhXRLtrF/pyo9RlDA/yeGFUQHZNbUfP4sFSH8Q6RSwS9CUMdxO+odW1Tgj6gSaa40nPUYjBRDqmc0zhok165lkZDM6moCVD7qT2sqglQa2FhlZF0ZjHVEze5VBhbJjIVYqXkGdEE4aME7XTXXhb6UI4myi53ndM1RII2XXNavR/NW87hTdJKMuXn2vHlyX4A5i2nuuguCVX176Pme3Om0ct9mXmwm8DFtcMoV11QXlBGyqVGFV3bWeZIBrqL72mCT
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 09:45:33.2850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b844d57a-649f-4581-c9a9-08df448f8649
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000525.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8842
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Maxime,

Thanks for the patch.
Tested-by: Yannick Fertre <yannick.fertre@foss.st.com>
Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>

Best regards


On 11/5/26 16:29, Maxime Ripard wrote:
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
>
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
>
> Switch to drm_mode_config_create_initial_state().
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Philippe Cornu <philippe.cornu@foss.st.com>
> Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> Cc: Yannick Fertre <yannick.fertre@foss.st.com>
> ---
>   drivers/gpu/drm/stm/drv.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> index 0967b9b3451d..60343ffe02f7 100644
> --- a/drivers/gpu/drm/stm/drv.c
> +++ b/drivers/gpu/drm/stm/drv.c
> @@ -105,5 +105,7 @@ static int drv_load(struct drm_device *ddev)
>   		return ret;
>   
> -	drm_mode_config_reset(ddev);
> +	ret = drm_mode_config_create_initial_state(ddev);
> +	if (ret)
> +		return ret;
>   	drm_kms_helper_poll_init(ddev);
>   
>
