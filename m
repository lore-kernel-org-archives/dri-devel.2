Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE75CD6E4A
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 03:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC6F112A55;
	Sun, 31 May 2026 03:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="HD+Gt2Aa";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9242112A55
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 03:14:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXBrY7CwdyuhHUHbPZlTqMDCJ0U3M8sLLhMUwA9XSYH9XUGIjXRURygQI/2Zo25WyNRW73Y24H6bd1Dua/uf/YdQ+BimoE3MB5pxyJ+uO3Sa2be6NsIsS9GogT7/JiRHIbqUBw7loU9AgG0c0J13/S5oQsfvCt3jRzmjy+W2PbdleWdCW2RT/PkVYPBhy9j2XQhmJQZn6pWndKwacZ9vDG8YjhgE33BI4QGvetjijjyxHrYmyJvIWS5YV4fcc4fQVkMHfKLbR7fALFhYX8UIHFtM/SkJdp+FS76rW1mg2PZMaG4yW3x5hKEfZ4COPsQl8Cqh7megwJLYS4R8SQAD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXokxgK2lgRzCDL8Mk/yMg/sEb8gCpi5D0RW61DG8JA=;
 b=BDUwn2JNx/hxGzBDC+XwzYFxTU9nxmMlD1VStihi+d/AjEJg2uJhjbl92QcjyjOHeGRpHdRUbo7RX8uItLThObLkX1WdcD9yyQmpPuNEoA8hhPHNYsvnG7SAc8XdMAtmIzNPDRSp7d0hwaxd9AQG81+/BAVJ5Zyk9hFfEspdAieLYhx3qQ0xKi6K+wFHotW/NoFA8MKVUOtwTw0ZRr662CLVJpPdVivURKt+xKFV5syWfDGCjSVAjweh/AHHwfhNnxxR2MnHyb4zYIL2hrclSQgmnH3FHF8yiu/EaT35BBZC6qhcaMMYNdv8nQXt0xu+zjwtc31cIx0sPMzjxTXLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXokxgK2lgRzCDL8Mk/yMg/sEb8gCpi5D0RW61DG8JA=;
 b=HD+Gt2Aa4h01mkuhRPIFCwhOkUbcj+6KMdKQgZozdW/SBIzbChPaxt9/pbskoQ6AxoPs+DuMFTO5+O5nCLONNy6FCBgDANx7QnAUR0khjMteElnsoP0sXaS6MuwNoJ+WyZUk8ZAj5IDi06Fs8jkB1TpjMbTAdSqnI6vy6X/sRN66V0JqnHP03VHP0UUrlMa79IQeEMzFnTBaXDg6zfyjsLWs5BowLAvsoRvioZD6rkH1J0kS9UTsY9f0dD7jFC8nGZ4N1jcPEBjARMOB1ZOfVO0qN9uLCHDXusnbQ5T/l8OPB52z0XkK/NoglcCkZ+w/dMWF/Z7WlxtwAOE0HPRysg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by VI1PR04MB7023.eurprd04.prod.outlook.com (2603:10a6:800:12f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Sun, 31 May
 2026 03:14:16 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0071.014; Sun, 31 May 2026
 03:14:16 +0000
Date: Sun, 31 May 2026 11:15:45 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 04/76] drm/bridge: Add new atomic_create_state callback
Message-ID: <ahun4SXEyW583UPY@raspi>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-4-875d828d31bc@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-4-875d828d31bc@kernel.org>
X-ClientProxiedBy: MA5P287CA0180.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::12) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|VI1PR04MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e67bbc-99b0-4f3e-2f3d-08debec2b293
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|19092799006|366016|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EXVKujPP9jFL/Ky1YOBpXoa9ZllSlBYAXGDMWlo4Ute5f1st2I9ZIPDFI38huLWB/wlbn7qvO3B9jtkaH3ktkUCIDBezj8Sh39TJZQkXe/ZzqGKy+iv4TABnGRzqVL3uACWolfpZcqwsRDiR5SaN11D9ajPTK8OiTKKCfdnFotmlrTXu9lzeWFsa1HJDnYmqV0OjROLjBncUbsyj2yqx/Sf4JVxKQq9GsgUTDwKANa3V16hluUbnoqap1LyH5tpH4cknYYrXar50F6wq6dUV1f5bv0ML14uzmTldINwSQ5xMym7I+U6ImyTJQXTejAIXUdrhzD8XV5RcwMkPOUbmxo93lwpohHoXlmnh0b3UAG4RGtNQ/CB23vf2kCw70ncLSHjECAAwmstcfka6V8fh8F3BbAaR9qEft5OsBw8K0ZUTcasx+C6Ik9TlRnXDeHxwbsMq74B+joSaS4LXpqOSD+sSC3CmWZki5yY6qGDdhsjuIbj+W1lmgTJr3VFo7HkAsLPQfblEyaSX5/35H11Iyrih9Tn2jCC0p+9OdASl7kAr29YGCH3eubHI3QLH+zQIEcdP7Hsh2nl/BUjZ18Wzo/Ym/hnLTu/Wj/blZu9Qvrv1Mbn7HbzWWhk72dh61BXr48gfNhYaMGpDHlA5YKwyORGm6BsIppsdv/FFtJOxpMiNbshKeeptqZuQIOdj7tOcbKMGoyxYRJmf18+nEbM6pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(19092799006)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dFQDnWPmc8YpClVVm8j0LmJuCt8GON6nDurQ622GRm/tdOJ5Ka61wGJnUuQx?=
 =?us-ascii?Q?1G0sYjbLqS9VHFQlI0lbnPSsJm/Z3nhTHrZexZhbvtOE0fPj0trdo0bSb+MP?=
 =?us-ascii?Q?pgn/hjGL+ozauj03lrC08V09ctUqJMOuFriOb/y8CVrRDjQawdovsWhb3M44?=
 =?us-ascii?Q?Pxv/TJlKrhrc4ufqbTD5Mr+2xhxkoknI/ThiDiaUt2Fiy+O+GRDoDZqfR+VC?=
 =?us-ascii?Q?xm6vW13MlyPbnm1ewq/RAIKBMRRqgnJr1TDEMCjQuAcwCwkaCiyZw7/7QDiW?=
 =?us-ascii?Q?CsjZXmg801a7+tRKlOGo64wqo+LSMAY/RB30gPQF5b7800nUz6rAXcwbGphe?=
 =?us-ascii?Q?obnmHbBDVTX7V1hCPx7EN81WhEaaLAzfz2OonWw5Wuvo9n/3vQj5TYbYK0+I?=
 =?us-ascii?Q?+e7oqb67TQ+QiqROG4+fK7/60okmuJCvJxeLBBxdcEav3vRymTT1TwzroNYB?=
 =?us-ascii?Q?N0epLeNLm7pbKzgXOsRzHfrvRH2SnC4e32JX6g5vgDgvZhpWQOVkiWpVL0eC?=
 =?us-ascii?Q?v9PbfKFGh3EP1xVV2qYzNe3cjqS3oqDURjE/xg14j1AI3X+Of3u8eH+QnkJ6?=
 =?us-ascii?Q?mf8MyNYi99fE/eoAHqUDc8wKa7n0Nkwxt+gswvurj0KETI/2bVrbkrztWpEu?=
 =?us-ascii?Q?Zf0D7o4eslSOZ0QCDiZP9spOEPGYQoK6C701uU10LliuFHvOGSGqSJ273/z8?=
 =?us-ascii?Q?jQUFuXKIg4j5fB/U4Lt9cCpWugBMFRzVkbWyGodIcoTK6oG/RMWi1KNAkqWs?=
 =?us-ascii?Q?WAfsJCbhh03pwMAGuARB0dyAwCmB4cbgOBa0xQ04gOnJnilq7yPGHfVd9bh8?=
 =?us-ascii?Q?DC+KSNbNmqFMLKL836NgtTHoOgZEGebl3Vcxkrtfa/6W508b/xvf178hcP+N?=
 =?us-ascii?Q?7D0cmIheBTO2bgjsEqvidIzHqn1oEYDw9LZVLZulV61aKAJbagVNRogOibnT?=
 =?us-ascii?Q?BGlM1rxCrrpXBAwuak0EX0/hgJJET+Jztw4V1zsQXxol4PPEyJVHtY/4QjKD?=
 =?us-ascii?Q?Rsa0OePgOuWwhFssW2nreOtgCoQCp5un4upHAI6gICm6hERSo2tnTM1z6nOg?=
 =?us-ascii?Q?FTqdOj0DMewIqb6XSnvt81fTFRO6oFC0WdmiYFTQo2cuMinMnpdZYJO+0xN7?=
 =?us-ascii?Q?3+3YemG5WYDPxk1qB5+qM5WZmVzxwCB0X8RIMucMg3CaJjwTDBnRgfQHFn8p?=
 =?us-ascii?Q?LIUM7DOiaULKEyMkudbuW0hCxJ4keWEveFzwlzAJYF6PSjjy/qgmXb4bkk2i?=
 =?us-ascii?Q?qsgFjZajZN1jcbo7gQ+whRNe2n2g0p4dz4kbN0CKaWP2mEsR5FK7ZrFL96B6?=
 =?us-ascii?Q?mFjzEnWAos0aWo9OKkDP7KG8EIUmtNt+cITXxrxhMh3FHLu2AwALRDmfcYj3?=
 =?us-ascii?Q?HNKyFxWG8kEPz+/UOr/mUxOVfq0kA93W8jxP801X7hxv884Tr8VNqTS6Qy5s?=
 =?us-ascii?Q?p88JCzHcRlC1XfdBEZ4HwJXLTbxBIPIccPaHSmPR8+FGbprsqLnvy39T2N/5?=
 =?us-ascii?Q?J1EydsCtRjpMZO3+kmWwXJIRNJmqIm5JIcjCkManpZW3qA6/rR7mA+hMAF5l?=
 =?us-ascii?Q?8Ub6IW4Y3k/kPicw4VRRvtlHeqdJRdHPEr6EyRrkpicNTpK0vG4jQmrCJzAb?=
 =?us-ascii?Q?zc/7fCVqVke0pM5PN4b9Kt3Ea7r/9Pgex/OUGBF3oBAt84qRn7lIi4+erT5e?=
 =?us-ascii?Q?Z41ARrdd1ZJuDNCohUQMU3gNdSVZIaV607HfEe3PrHv5dzvmARszN1dvKgGk?=
 =?us-ascii?Q?NpvKzxoL1w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e67bbc-99b0-4f3e-2f3d-08debec2b293
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 03:14:16.6256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCn1A9lcrqk2m8AGDORaXkEyA2F6un6G+dgZVmV1OytLIZAQEQiY041ux/2NyB9M82dWSCseXi4nvsQfalGJZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7023
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

On Sat, May 30, 2026 at 03:59:09PM +0200, Maxime Ripard wrote:

[...]

> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 4ba3a5deef9a..a6c07d339afa 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -502,35 +502,24 @@ struct drm_bridge_funcs {
>  			    struct drm_bridge_state *bridge_state,
>  			    struct drm_crtc_state *crtc_state,
>  			    struct drm_connector_state *conn_state);
>  
>  	/**
> -	 * @atomic_reset:
> +	 * @atomic_create_state:
>  	 *
> -	 * Reset the bridge to a predefined state (or retrieve its current
> -	 * state) and return a &drm_bridge_state object matching this state.
> -	 * This function is called at attach time.
> -	 *
> -	 * The atomic_reset hook is mandatory if the bridge implements any of
> -	 * the atomic hooks, and should be left unassigned otherwise. For
> -	 * bridges that don't subclass &drm_bridge_state, the
> -	 * drm_atomic_helper_bridge_reset() helper function shall be used to
> -	 * implement this hook.
> -	 *
> -	 * Note that the atomic_reset() semantics is not exactly matching the
> -	 * reset() semantics found on other components (connector, plane, ...).
> -	 *
> -	 * 1. The reset operation happens when the bridge is attached, not when
> -	 *    drm_mode_config_reset() is called
> -	 * 2. It's meant to be used exclusively on bridges that have been
> -	 *    converted to the ATOMIC API
> +	 * Allocate a pristine, initialized, state for the bridge
> +	 * object and return it. This callback must have no side
> +	 * effects: in particular, the returned state must not be
> +	 * assigned to the object's state pointer and it must not affect
> +	 * the hardware state.
>  	 *
>  	 * RETURNS:
> -	 * A valid drm_bridge_state object in case of success, an ERR_PTR()
> -	 * giving the reason of the failure otherwise.
> +	 *
> +	 * A new, pristine, bridge state instance or an error pointer
> +	 * on failure.
>  	 */
> -	struct drm_bridge_state *(*atomic_reset)(struct drm_bridge *bridge);
> +	struct drm_bridge_state *(*atomic_create_state)(struct drm_bridge *bridge);

Drivers haven't been converted to use atomic_create_state, isn't this causing
build breaks?

-- 
Regards,
Liu Ying
